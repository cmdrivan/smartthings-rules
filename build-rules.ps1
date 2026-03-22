$replacements = @{
  "DN2_Left_Shade" = "d28bf561-022d-45b8-9499-57fbd7e2d010"
  "DN2_Left_Shade_Bottom" = "11f0492e-b740-4aa9-971e-fe51de875337"
  "DN2_Left_Shade_Top" = "ba89d7b1-f3c1-4b62-830c-749d81b4d0e9"
  "DN3_Right_Shade" = "55e52bec-d38d-4db3-8318-cd3da326c0cb"
  "DN3_Right_Shade_Bottom" = "27c7fea9-0b5a-4baa-98f6-34167173d114"
  "DN3_Right_Shade_Top" = "c12c22eb-7032-47f6-af1f-f8c453c3c62b"
  "DN5_Small_Shade" = "cb24aadd-782f-49bf-838f-0c491cd92a30"
  "DR1_Shade" = "de0fa792-d840-476c-9f8c-bfe01f7ac30f"
  "DR1_Shade_Bottom" = "1844a4d2-b6ed-456e-b8bd-7fc66223305a"
  "DR1_Shade_Top" = "27452fdd-b4ba-4a86-969a-5bd94191c3fc"
  "Dryer" = "b7753ffb-ef48-b91e-0439-ff525e36e0e4"
  "FP3_Left_Shade" = "c004ec3e-55e1-44aa-ab0b-d6031510164c"
  "FP4_Right_Shade" = "52a2d7a9-b111-4862-97e4-38aa8286b10f"
  "Front_Door_Lock" = "a19b372a-ed30-40f0-b344-aec997868e5b"
  "Garage_Door" = "c253e024-2870-4290-a2e3-8bb22a8e5a7d"
  "Garage_Door_Lock" = "f366828e-7286-491d-8aa1-9c669b9f3241"
  "GR4_Left_Shade" = "2a093077-662b-4ab2-a344-d26987607126"
  "GR4_Left_Shade_Bottom" = "7565ec60-c8db-438d-8872-04dc9ca4580c"
  "GR4_Left_Shade_Top" = "7ad31aa4-0217-4e57-9995-135cbe0c25ee"
  "GR5_Middle_Shade" = "91cdf0f2-190e-499f-9c20-1e92c760e951"
  "GR5_Middle_Shade_Bottom" = "d769c8af-12ec-46b4-8022-cda0074975d7"
  "GR5_Middle_Shade_Top" = "3b5a7dd6-57f6-4376-9efb-927313d2b6e0"
  "GR6_Right_Shade" = "ff469966-f710-400b-9676-fe81e90b2728"
  "GR6_Right_Shade_Bottom" = "0012c07f-9a2c-45b7-b94d-6854bee27661"
  "GR6_Right_Shade_Top" = "2fd91886-ccae-43bd-b436-1d8984da62db"
  "Kitchen_Controller" = "896e8cc7-4472-4251-bdf9-0ba923612f27"
  "Living_Room_Controller" = "615f6812-7a32-4fb4-ba85-2e65b60faf03"
  "Living_Room_TV" = "f55ff25a-588f-5912-5e58-464e79c73c43"
  "Office_Controller" = "fe99531d-65da-4c0c-9a10-fd81e9730943"
  "PB6_Small_Shade" = "b41fbe42-0aa7-40fb-8248-abb9e4d9aec4"
  "PB7_Left_Shade" = "357a04d7-46f1-453e-90ee-d042d93b708e"
  "PB7_Left_Shade_Bottom" = "a54e7678-1ffa-49fc-901f-306e61914606"
  "PB7_Left_Shade_Top" = "8015cfee-72dc-47d6-8202-aabe8702c9bc"
  "PB8_Middle_Shade" = "75243bdc-0f41-4116-97da-81eba8914917"
  "PB8_Middle_Shade_Bottom" = "a2e25df8-1ba9-4d6c-9869-a29e098e1484"
  "PB8_Middle_Shade_Top" = "e9d96f39-c7e6-4df3-af9f-90891e018df6"
  "PB9_Right_Shade" = "070eeffd-cca1-4fad-86d1-1462482a87fa"
  "PB9_Right_Shade_Bottom" = "c4559cf6-fbc2-4a9c-83a4-5f6e61cb1e2d"
  "PB9_Right_Shade_Top" = "61c3e363-a8a6-4d32-a3ca-3c070a1252a0"
  "Primary_Bedroom_Controller" = "28372dcc-8d51-4aa5-8309-ecacc958d297"
  "Refrigerator" = "15f59c67-60f0-f76c-fa24-55df29228df4"
  "SmartThings_Hub" = "cdfe765e-6760-4226-9c09-01b2881da887"
  "ST1_Left_Shade" = "192ca75a-e06e-4f84-a0d9-6e1d39a919fe"
  "ST2_Right_Shade" = "a5d65311-5d7a-44f3-9e3c-a6450e01f7b9"
  "Thermostat" = "04926592-400c-4a6f-ad8e-dc57bfbb41c9"
  "Washer" = "d38cd381-ec98-5479-e36b-3023493a630e"
}

Get-ChildItem *.json | ForEach-Object {
  # Load file
  $content = Get-Content $_.FullName

  # Replace placeholders
  foreach ($key in $replacements.Keys) {
    $content = $content -replace "{{$key}}", $replacements[$key]
  }

  Set-Content transformed-rule.json $content
  smartthings rules:create -l 208e3b71-4001-4128-a9db-2c3ea2497660 -i transformed-rule.json
  Remove-Item transformed-rule.json
}