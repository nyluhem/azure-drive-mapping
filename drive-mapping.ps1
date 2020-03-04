$connectTestResult = Test-NetConnection -ComputerName cbaddevnetstorage.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"cbaddevnetstorage.file.core.windows.net`" /user:`"Azure\cbaddevnetstorage`" /pass:`"qOhDMNcL6xnVZSnxejCBwRhHo765SaSwbiYuNPJ+sAZHVgPcBZPQaSIPHgrZhKvlD0/Kj6NIGbICv92jgO+cCQ==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\cbaddevnetstorage.file.core.windows.net\code"-Persist
    New-PSDrive -Name S -PSProvider FileSystem -Root "\\cbaddevnetstorage.file.core.windows.net\software" -Persist
    New-PSDrive -Name X -PSProvider FileSystem -Root "\\cbaddevnetstorage.file.core.windows.net\configuration" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}