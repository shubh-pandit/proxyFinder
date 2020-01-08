const DOT = "."
const proxy_init = "172.16." 'the intials of the proxy
const proxy_port = ":8080" 'the port of the proxy, using the most common one
Dim WSHShell
Dim first_var, second_var, RegLocate, proxy, success
Set WSHShell = WScript.CreateObject("WScript.Shell")
RegLocate = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyServer"

first_var = 0 
second_var = 0
'initialising the third and fourth fragment of the proxy with 0
'change it as required, guesswork is important
success = FALSE
while first_var < 256 And success = FALSE 'the highest number used in an ip address is 255
    while second_var < 256 And success = FALSE
        StartTime = Timer()
        proxy = proxy_init & CStr(first_var)
        proxy = proxy & DOT
        proxy = proxy & CStr(second_var)
        proxy = proxy & proxy_fin
        'concatenating proxy
        WScript.Echo "Currently running : " & proxy
        WSHShell.regwrite RegLocate, proxy, "REG_SZ" 'substituting the new proxy in the registry
        success = check_proxy()
        if success = TRUE then
            WSHShell.Popup "Proxy found :" & proxy, 0, "Proxy Finder" 'notifies the user with a popup if a proxy is found
        else 
            success = FALSE
        end if
        EndTime = Timer()
        WScript.Echo "Seconds to 2 decimal places: " & FormatNumber(EndTime - StartTime, 2)
        second_var = second_var + 1

        Wend
    first_var = first_var + 1 'iterating through all possible combinations
Wend


Function check_proxy()
    dim objShell, objPing, str_server
    dim strPingOut, flag
    str_server = "google.com" 
    set objShell = CreateObject("WScript.Shell")
    set objPing = objShell.Exec("ping " & str_server) 'pinging google.com to check if the proxy works
    strPingOut = objPing.StdOut.ReadAll
    if instr(LCase(strPingOut),"reply") then 'if the word reply is present in the response then the packets were sent successfully
        flag = TRUE
    else    
        flag = FALSE
    end if
    check_proxy = flag 'flag is returned
end Function
