// groups.yaml basic validation

// require: >= 2 groups
// Using a let statement to define the constraint
let minGroups = 2
if len(groups) < minGroups {
    _|_: "groups must contain at least \(minGroups) entries"
}

// top-level structure
groups: [string]: Group

// === types ===
Version: {
    softwareVersion: string & !=""
}

Group: {
    type: "QG" | "DV"

    software: {
        // common required components (both)
        "Telemetry-Producer": Version
        "PanelPC-API":        Version
        "PanelPC-GUI":        Version
        "Plc-Tool":           Version

        // QG-only requirements
        if type == "QG" {
            "QG":               Version
            "Calibration-Tool": Version

            // forbid DV component on QG
            // This is handled by a constraint that makes the entire
            // software field an error if "DV" exists.
            "DV": _|_
        }

        // DV-only requirements
        if type == "DV" {
            "DV": Version

            // forbid QG + Calibration-Tool on DV
            "QG":               _|_
            "Calibration-Tool": _|_
        }
    }
}