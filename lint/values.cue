// Basic, readable rules for groups.yaml

// require: >= 2 groups
if len(groups) < 2 {
	_|_: "groups must contain at least 2 entries"
}

// top-level structure
groups: [string]: Group

// === types ===
Version: {
	softwareVersion: string & != ""
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
			for k, _ in software if k == "DV" {
				_|_: "'DV' component not allowed on QG groups"
			}
		}

		// DV-only requirements
		if type == "DV" {
			"DV": Version

			// forbid QG + Calibration-Tool on DV
			for k, _ in software if k == "QG" {
				_|_: "'QG' component not allowed on DV groups"
			}
			for k, _ in software if k == "Calibration-Tool" {
				_|_: "'Calibration-Tool' not allowed on DV groups"
			}
		}
	}
}