# 1. Define your data (This could also be imported from a CSV)
$rules = @(
    @{ Name = "LR Button 4 DR1 Top"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button4"; Shade = "cc671f4c-8944-4dd8-973b-5daeaa3aa2f4" },
    @{ Name = "DN Button 1 DN2 Top"; Controller = "4bf0d189-4d2e-41fe-a6af-45a38be1bc88"; Button = "button1"; Shade = "6d203403-2326-4cfc-a68b-591b35272ab6" },
    @{ Name = "DN Button 2 DN3 Top"; Controller = "4bf0d189-4d2e-41fe-a6af-45a38be1bc88"; Button = "button2"; Shade = "d8580ba8-161b-46ad-9525-acd9ef8bf810" },
    @{ Name = "LR Button 1 GR4 Top"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button1"; Shade = "16f36a30-fb08-412a-9d30-00b39168eca7" },
    @{ Name = "LR Button 2 GR5 Top"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button2"; Shade = "4b31719f-ac3d-4402-9e08-77fa19bdd2e2" },
    @{ Name = "LR Button 3 GR6 Top"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button3"; Shade = "cf3b7491-7021-47b8-90b2-d12f808711ea" },
    @{ Name = "PB Button 2 PB7 Top"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button2"; Shade = "0a5e6196-7dc2-436e-bc40-323afd40427e" },
    @{ Name = "PB Button 3 PB8 Top"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button3"; Shade = "efc09eb1-7f63-40ec-9e60-0beb8a913dd6" },
    @{ Name = "PB Button 4 PB9 Top"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button4"; Shade = "6505d79b-9511-402f-9b75-6dfae5d735aa" }
)

# 2. Define your template string (Use @' '@ for multi-line strings)
$template = @'
{
  "name": "RULE_NAME",
  "actions": [
    {
      "if": {
        "equals": {
          "left": {
            "device": {
              "devices": ["CONTROLLER_ID"],
              "component": "BUTTON_ID",
              "capability": "button",
              "attribute": "button"
            }
          },
          "right": {
            "string": "pushed_3x"
          }
        },
        "then": [
          {
            "command": {
              "devices": ["SHADE_ID"],
              "commands": [
                {
                  "component": "topmotor",
                  "capability": "windowShadeLevel",
                  "command": "setShadeLevel",
                  "arguments": [{"integer": 2}]
                }
              ]
            }
          }
        ],
        "else": [
          {
            "if": {
              "equals": {
                "left": {
                  "device": {
                    "devices": ["CONTROLLER_ID"],
                    "component": "BUTTON_ID",
                    "capability": "button",
                    "attribute": "button"
                  }
                },
                "right": {
                  "string": "pushed_4x"
                }
              },
              "then": [
                {
                  "command": {
                    "devices": ["SHADE_ID"],
                    "commands": [
                      {
                        "component": "topmotor",
                        "capability": "windowShadeLevel",
                        "command": "setShadeLevel",
                        "arguments": [{"integer": 100}]
                      }
                    ]
                  }
                }
              ],
              "else": [
                {
                  "if": {
                    "equals": {
                      "left": {
                        "device": {
                          "devices": ["CONTROLLER_ID"],
                          "component": "BUTTON_ID",
                          "capability": "button",
                          "attribute": "button"
                        }
                      },
                      "right": {
                        "string": "down_hold"
                      }
                    },
                    "then": [
                      {
                        "command": {
                          "devices": ["SHADE_ID"],
                          "commands": [
                            {
                              "component": "topmotor",
                              "capability": "windowShade",
                              "command": "pause"
                            }
                          ]
                        }
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  ]
}
'@

# 3. Loop and Generate
foreach ($item in $rules) {
    $content = ($template.Replace("RULE_NAME", $item.Name)).
                Replace("CONTROLLER_ID", $item.Controller).
                Replace("BUTTON_ID", $item.Button).
                Replace("SHADE_ID", $item.Shade)
    
    $fileName = "$($item.Name).json"
    $content | Out-File -FilePath $fileName -Encoding utf8
    Write-Host "Generated: $fileName"
}