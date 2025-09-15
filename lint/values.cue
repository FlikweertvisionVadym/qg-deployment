package values

#Version: {
    softwareVersion: string & !=""
}

// --- QG definition
#QGGroup: {
    type: "QG"
    software: {
        "Telemetry-Producer": #Version
        "PanelPC-API":        #Version
        "PanelPC-GUI":        #Version
        "Plc-Tool":           #Version
        "QG":                 #Version
        "Calibration-Tool":   #Version

        // forbid DV
        "DV"?: _|_
    }
}

// --- DV definition
#DVGroup: {
    type: "DV"
    software: {
        "Telemetry-Producer": #Version
        "PanelPC-API":        #Version
        "PanelPC-GUI":        #Version
        "Plc-Tool":           #Version
        "DV":                 #Version

        // forbid QG & Calibration-Tool
        "QG"?:               _|_
        "Calibration-Tool"?: _|_
    }
}

// --- Group is either QGGroup or DVGroup
#Group: #QGGroup | #DVGroup

// --- top-level
groups: [string]: #Group