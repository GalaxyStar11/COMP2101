# param statement is used to add parametes to the script
# switch type is specified to indicate they do not require an object on the cmd line
param ([switch]$System, [switch]$Disks, [switch]$Network)

# ------------------------------------------------
# System Hardware Report function:
function systemreport {
    # variable to store value from the wmi object win32_computersystem class
    $hardwareInfo = Get-WmiObject win32_computersystem
    $myHardwareObjects = $hardwareInfo |
                            foreach { $hardware=$_;
                                # new object is created for the data
                                        New-Object PSObject -Property @{Name=$hardware.name;
                                                                        Manufacturer=$hardware.manufacturer;
                                                                        Model=$hardware.model;
                                                                        Status=$hardware.status;
                                                                        Description=$hardware.description;
                                                                        "System Type"=$hardware.systemtype
                                                                        }
                                        }
    Write-Output "------------------------------ SYSTEM REPORT -----------------------------------"
    # format statement is used to format it in a organized list
    $myHardwareObjects | Format-List Name, Manufacturer, Model, Description, Status, "System Type"
}


# -------------------------------------------------
# OS Report:
function osreport {
    # variable to store value from the wmi object win32_operatingsystem class
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
    # format statement is used to format it in a organized list
    $myOSInfo | Format-List Name, Manufacturer, Version, SerialNumber, OSType, OSSKU, Buildtype, BuildNUmber
}


# --------------------------------------------------
# Processor Report:
function processorreport {
    # variable to store value from the wmi object win32_processor class
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
    # format statement is used to format it in a organized list
    $myProcessorInfo | Format-List Name, Description, Speed, "Number of Cores", Socket, L1cache, L2cache, L3cache
}


# ---------------------------------------------------
# RAM report:
function ramreport {
    # default variable for total capacity
    $totalCapacity = 0
    # variable to store value from the wmi object win32_physicalmemory class
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
    # format statement is used to format it in a organized table
    $myRamInfo | Format-Table -AutoSize Name, Vendor, Description, "Size(MB)", "Speed(MHz)", Bank, Slot
    # Total RAM capacity is displayed at the bottom of the table
    "Total RAM: ${totalCapacity}MB"
    }


# ---------------------------------------------------
# Disk Report function:
function diskreport {
Write-Output "------------------------------ DISK REPORT -----------------------------------"
    # Nested foreach statements are used to gather data from multiple wmi objects
    # variable to store value from the wmi object win32_diskdrive class
    $diskInfo= Get-CimInstance win32_diskdrive
    foreach ($disk in $diskInfo) {
        # variable to store value from the wmi object win32_diskpartition class
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName win32_diskpartition
        foreach ($partition in $partitions) {
            # variable to store value from the wmi object win32_logicaldisk class
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
                # format statement is used to format it in a organized table
                Format-Table -AutoSize
            }
        }
    }
}


# ------------------------------------------------
# Ip configuration Report:
function networkreport {
    # variable to store value from the wmi object win32_networkadaptrconfiguration class
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
    # format statement is used to format it in a organized table
    $myNetworkObjects | format-table -autosize Name, "Adapter Description", index, IPAddress, "Subnet Mask", "DNS Domain Name", "DNS Server"
}


# -------------------------------------------------
# Video Card Report:
function videoreport {
    # variable to store value from the wmi object win32_videocontroller class
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
     # format statement is used to format it in a organized list
     $myVideoCards | Format-List Name,Description, Manufacturer,"Refresh Rate", Resolution
}

# If -System parameter is passed on the cmd line, only certain functions are displayed
if ($System) {
    systemreport
    osreport
    processorreport
    ramreport
    videoreport
    
}
# If -Disks parameter is passed on the cmd line, only diskreport function is displayed
if ($Disks) {
    diskreport

}
# If -Network parameter is passed on the cmd line, only networkreport function is displayed
if ($Network) {
    networkreport

}
# If no parameter is passed, all the reports are displayed
if (-not ($System -or $Disks -or $Network)) {
    systemreport
    osreport
    processorreport
    ramreport
    videoreport
    networkreport
    diskreport
}