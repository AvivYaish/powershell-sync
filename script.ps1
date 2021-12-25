# Specify in folder_pairs the sources and targets, the script will
# iterate over them and mirror each source to the matching target
$folder_pairs = @(
    [System.Tuple]::Create("source1", "target1"), 
    [System.Tuple]::Create("source2", "target2")
    # etc
)
foreach ($folder_pair in $folder_pairs) {
    $source = $folder_pair.Item1
    $target = $folder_pair.Item2
    $exists = $TRUE
    foreach ($path in @($source, $target)) {
        if (-Not (Test-Path -Path $path)) {
            "$path doesn't exist."
            $exists=$FALSE
        }
    }
    if ($exists) {
        robocopy $source $target /mir /zb /mt
        # robocopy is Windows' built-in file copy tool
        # /mir - mirrors source to target
        # /mt - multithreading
        # /zb - 'z' allows restarting, 'b' is backup mode (allows copying files that you might not have access to)
        # For more details, see:
        # https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy 
    }
}