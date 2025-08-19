<h1>QB-Core Scavenging Script</h1>

<li><strong>Video Preview: Unavaliable </strong></li>
<li><strong>I have kept the debug commands inside the resource as a reference as how you can add admin commands to your server for the XP!</strong></li>

## Dependencies

[Oxlib/oxmysql](https://github.com/overextended/oxmysql)


<h4>Features</h4>

<ul>
    <li>Open Source</li>
    <li>Reputation System</li>
    <li>NPC For Users To Access Their XP</li>
    <li>Customizable Configuration File</li>
    <li>Ability To Add More Entities</li>
</ul>

<h4>Installation</h4>

<ol>
  <li>Download the repository <a href="https://github.com/sam-scripts/sam-scavenging">here</a>.</li>
  <li>Extract the folder and upload it to your servers resource folder</li>
    <li>You will also need to run the SQL query inside your servers database</li>
</ol>

<h4>Configuration File</h4>

```

-- Ped Character
Config.Ped = "a_m_o_soucent_03"

-- Ped Coords
Config.PedCoords = vector4(-178.79, -1259.90, 32.6-2, 90.43) 

Config.LootableItems = {
    "prop_dumpster_02a",
    "prop_dumpster_01a",
    "prop_bin_01a",
    "prop_bin_02a",
    "prop_bin_07c",

}

-- Scavenging Properties
Config.ScavengeTime = 8000

Config.CooldownTime = 60000

-- Scavenging Items

Config.LowRepItems = { 
}

Config.MediumRepItems = { 
    
}

Config.HighRepItems = { 
    
}
```

<br>

If you are in need of any help please add me on discord and I will try as best as I can to respond fast (sam7870).
