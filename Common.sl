# common functions

sub Getinfo {
    @infos = @();
    $handle = openf(script_resource("setting.txt"));
    while $line (readln($handle))
    {
        $line = split(' = ', $line)[1];
        add(@infos,$line,-1);
    }
    return @infos;
}

sub Getname{
    local('$fname');
    $fname = "";
    @array = @("a", "b", "c", "d", "e", "f", "g", "h", "i" ,"0", "1", "2", "3", "4", "5", "6", "7", "8", "9");
    $total = 12;
    while($total >= 0){
        $fname = $fname.rand(@array);
        $total = $total - 1;
    }
    return $fname.".exe";
}

