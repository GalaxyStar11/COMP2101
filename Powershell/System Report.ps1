#System Information Script

#------------------------------------------------
#System Hardware Report:
function systemreport {
    $hardwareInfo = Get-WmiObject win32_computersystem
    $myHardwareObjects = $hardwareInfo |
                            foreach { $hardware=$_;
                                        New-Object PSObject -Property @{Name=$hardware.name;
                                                                        Manufacturer=$hardware.manufacturer;
                                                                        Model=$hardware.model;
                                                                        Status=$hardware.status;
                                                                        Description=$hardware.description;
                                                                        "System Type"=$hardware.systemtype
                                                                        }
                                        }
    Write-Output "------------------------------ SYSTEM REPORT -----------------------------------"
    $myHardwareObjects | Format-List Name, Manufacturer, Model, Description, Status, "System Type"
}

systemreport

#-------------------------------------------------
#OS Report:
function osreport {
    $osInfo = Get-WmiObject win32_operatingsystem
    $myOSInfo = $osInfo |
                    foreach { $os=$_;
                                New-Object PSObject -Property @{Name=$os.name;
                                                                 Manufacturer=$os.manufacturer;
                                                                 Version=$os.version;
                                                                 SerialNumber=$os.serialnumber;
                                                                 Buildtype=$os.buildtype;
                                                                 Buildnumber=$os.buildnumber
                                                                 }
                               }
    Write-Output "------------------------------ OS REPORT -----------------------------------"
    $myOSInfo | Format-List Name, Manufacturer, Version, SerialNumber, OSType, OSSKU, Buildtype, BuildNUmber
}

osreport

#--------------------------------------------------
#Processor Report:
function processorreport {
    $processorInfo= Get-WmiObject win32_processor
    $myProcessorInfo = $processorInfo |
                            foreach { $processor=$_;
                                        New-Object PSObject -Property @{Name=$processor.name;
                                                                        Description=$processor.description;
                                                                        Speed=$processor.maxclockspeed;
                                                                        "Number of Cores"=$processor.numberofcores;
                                                                        Socket=$processor.socketdesignation;
                                                                        L1cache=$processor.l1cachesize;
                                                                        L2cache=$processor.l2cachesize;
                                                                        L3cache=$processor.l3cachesize
                                                                        }
                                    }
    Write-Output "------------------------------ PROCESSOR REPORT -----------------------------------"
    $myProcessorInfo | Format-List Name, Description, Speed, "Number of Cores", Socket, L1cache, L2cache, L3cache
}

processorreport

#---------------------------------------------------
#RAM report:
function ramreport {
    $totalCapacity = 0
    $ramInfo = Get-WmiObject win32_physicalmemory
    $myRamInfo = $ramInfo |
                    foreach { $ram=$_;
                                New-Object PSObject -Property @{Name=$ram.name;
                                                                Vendor=$ram.manufacturer;
                                                                Description=$ram.description;
                                                                "Size(MB)"=$ram.capacity/1mb;
                                                                "Speed(MHz)"=$ram.speed;
                                                                Bank=$ram.banklabel;
                                                                Slot=$ram.devicelocator
                                                                }
                            $totalCapacity+=$ram.capacity/1mb
                            }
    Write-Output "------------------------------ RAM REPORT -----------------------------------"
    $myRamInfo | Format-Table -AutoSize Name, Vendor, Description, "Size(MB)", "Speed(MHz)", Bank, Slot
    "Total RAM: ${totalCapacity}MB"
    }

ramreport

#---------------------------------------------------
#Disk Report:
function diskreport {
Write-Output "------------------------------ DISK REPORT -----------------------------------"
    $diskInfo= Get-CimInstance win32_diskdrive
    foreach ($disk in $diskInfo) {
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName win32_diskpartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName win32_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                New-Object -TypeName PSObject -Property @{Name=$disk.name;
                                                          Manufacturer=$disk.manufacturer;
                                                          Model=$disk.model;
                                                          Location=$partition.deviceid;
                                                          Drive=$logicaldisk.deviceid;
                                                          "Size(GB)"=$logicaldisk.size / 1gb -as [int];
                                                          "Free Space(GB)"=[math]::Round($logicaldisk.freespace / 1gb);
                                                          "Percentage Free"=[math]::Round(($logicaldisk.freespace / $logicaldisk.size ) * 100)
                                                          } |
                Format-Table -AutoSize
            }
        }
    }
}

diskreport

#------------------------------------------------
#Ip configuration Report:
function networkreport {
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
    Write-Output "------------------------------ NETWORK REPORT -----------------------------------"
    $myNetworkObjects | format-table -autosize Name, "Adapter Description", index, IPAddress, "Subnet Mask", "DNS Domain Name", "DNS Server"
}

networkreport

#-------------------------------------------------
#Video Card Report:
function videoreport {
    $videoCards = Get-WmiObject win32_videocontroller
    $myVideoCards = $videoCards|
                           foreach { $videoCard=$_;
                                        New-Object -TypeName PSObject -Property @{Name=$videoCard.name;
                                                                                  Description=$videoCard.description;
                                                                                  Manufacturer=$videoCard.videoprocessor;
                                                                                  "Refresh Rate"=$videoCard.maxrefreshrate;
                                                                                  "Horizontal Resolution"=$videoCard.currenthorizontalresolution; 
                                                                                  "Vertical Resolution"=$videoCard.currentverticalresolution;
                                                                                  Resolution=($videoCard.currenthorizontalresolution,"x", $videoCard.currentverticalresolution)
                                                                                  }
                                        }
     Write-Output "------------------------------ VIDEO REPORT -----------------------------------"
     $myVideoCards | Format-List Name,Description, Manufacturer,"Refresh Rate", Resolution
}

videoreport