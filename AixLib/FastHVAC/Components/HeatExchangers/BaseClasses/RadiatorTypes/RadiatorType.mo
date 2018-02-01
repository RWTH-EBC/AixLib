within AixLib.FastHVAC.Components.HeatExchangers.BaseClasses.RadiatorTypes;
type RadiatorType = Real[2] annotation (choices(
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.SectionalRadiator
      "Simple (vertical) sectional radiator",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator10
      "10 -- Panel radiator (single panel) without convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator11
      "11 -- Panel radiator (single panel) with one convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator12
      "12 -- Panel radiator (single panel) with two convection devices",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator20
      "20 -- Panel radiator (two panels) without convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator21
      "21 -- Panel radiator (two panels) with one convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator22
      "22 -- Panel radiator (two panels) with two convection devices",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator30
      "30 -- Panel radiator (three panels) without convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator31
      "31 -- Panel radiator (three panels) with one convection device",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.PanelRadiator32
      "32 -- Panel radiator (three panels) with two or more convection devices",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.ConvectorHeaterUncovered
      "Convector heater without cover",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.ConvectorHeaterCovered
      "Convector heater with cover",
    choice=HVAC.Components.HeatExchanger.BaseClasses.RadiatorTypes.Kermi_V_Plan_22
      "Kermi V-Plan Type 22"));
