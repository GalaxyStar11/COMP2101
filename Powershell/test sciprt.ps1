
#Ip configuration Report:

$adapters = Get-CimInstance win32_networkadapterconfiguration
$filteredAdapters = $adapters | Where-Object { $_.IPEnabled -eq $TRUE }
$myNetworkObjects = $filteredAdapters |
                            foreach { $adapter=$_;
                                        New-Object PSObject -Property @{Name=$adapter.servicename;
                                                                        "Adapter Description"=$adapter.Description;
                                                                        index=$adapter.index;
                                                                        IPAddress=$adapter.ipaddress;
                                                                        "Subnet Mask"=$adapter.ipsubnet;
                                                                        "DNS Domain Name"=$adapter.dnsdomain;
                                                                        "DNS Server"=$adapter.dnsserversearchorder
                                                                        }
                                        }
$myNetworkObjects | format-table -autosize Name, "Adapter Description", index, IPAddress, "Subnet Mask", "DNS Domain Name", "DNS Server"
