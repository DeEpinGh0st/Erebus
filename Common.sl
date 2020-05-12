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

