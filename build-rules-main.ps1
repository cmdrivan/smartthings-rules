# 1. Define your data (This could also be imported from a CSV)
$rules = @(
    @{ Name = "LR Button 4 DR1"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button4"; Shade = "cc671f4c-8944-4dd8-973b-5daeaa3aa2f4" },
    @{ Name = "DN Button 1 DN2"; Controller = "4bf0d189-4d2e-41fe-a6af-45a38be1bc88"; Button = "button1"; Shade = "6522a7b1-1ed2-4ef7-865f-a0b89777f056" },
    @{ Name = "DN Button 2 DN3"; Controller = "4bf0d189-4d2e-41fe-a6af-45a38be1bc88"; Button = "button2"; Shade = "b45cbc98-a70d-484a-b9cb-c15477369f00" },
    @{ Name = "LR Button 1 GR4"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button1"; Shade = "16f36a30-fb08-412a-9d30-00b39168eca7" },
    @{ Name = "LR Button 2 GR5"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button2"; Shade = "4b31719f-ac3d-4402-9e08-77fa19bdd2e2" },
    @{ Name = "LR Button 3 GR6"; Controller = "caed018d-fd45-4826-84e7-fa7ff464bada"; Button = "button3"; Shade = "cf3b7491-7021-47b8-90b2-d12f808711ea" },
    @{ Name = "PB Button 2 PB7"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button2"; Shade = "0a5e6196-7dc2-436e-bc40-323afd40427e" },
    @{ Name = "PB Button 3 PB8"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button3"; Shade = "efc09eb1-7f63-40ec-9e60-0beb8a913dd6" },
    @{ Name = "PB Button 4 PB9"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button4"; Shade = "6505d79b-9511-402f-9b75-6dfae5d735aa" },
    @{ Name = "KT Button 1 ST1"; Controller = "695813a2-0174-4cf5-841f-560837a8e44c"; Button = "button1"; Shade = "192ca75a-e06e-4f84-a0d9-6e1d39a919fe" },
    @{ Name = "KT Button 2 ST2"; Controller = "695813a2-0174-4cf5-841f-560837a8e44c"; Button = "button2"; Shade = "a5d65311-5d7a-44f3-9e3c-a6450e01f7b9" },
    @{ Name = "KT Button 3 FP3"; Controller = "695813a2-0174-4cf5-841f-560837a8e44c"; Button = "button3"; Shade = "c004ec3e-55e1-44aa-ab0b-d6031510164c" },
    @{ Name = "KT Button 4 FP4"; Controller = "695813a2-0174-4cf5-841f-560837a8e44c"; Button = "button4"; Shade = "52a2d7a9-b111-4862-97e4-38aa8286b10f" },
    @{ Name = "DN Button 3 DN5"; Controller = "4bf0d189-4d2e-41fe-a6af-45a38be1bc88"; Button = "button3"; Shade = "cb24aadd-782f-49bf-838f-0c491cd92a30" },
    @{ Name = "PB Button 1 PB6"; Controller = "2e003fd7-663e-422e-b921-42b432b5c15a"; Button = "button1"; Shade = "b41fbe42-0aa7-40fb-8248-abb9e4d9aec4" }
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
            "string": "pushed"
          }
        },
        "then": [
          {
            "command": {
              "devices": ["SHADE_ID"],
              "commands": [
                {
                  "component": "main",
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
                  "string": "pushed_2x"
                }
              },
              "then": [
                {
                  "command": {
                    "devices": ["SHADE_ID"],
                    "commands": [
                      {
                        "component": "main",
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
                        "string": "down_hold"
                      }
                    },
                    "then": [
                      {
                        "command": {
                          "devices": ["SHADE_ID"],
                          "commands": [
                            {
                              "component": "main",
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

    # smartthings rules:create -l 208e3b71-4001-4128-a9db-2c3ea2497660 -i $fileName
}