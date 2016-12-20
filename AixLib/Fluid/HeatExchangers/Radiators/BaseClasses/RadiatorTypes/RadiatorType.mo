within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes;
type RadiatorType = Real[2] annotation (choices(
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.SectionalRadiator
      "Simple (vertical) sectional radiator",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator10
      "10 -- Panel radiator (single panel) without convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator11
      "11 -- Panel radiator (single panel) with one convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator12
      "12 -- Panel radiator (single panel) with two convection devices",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator20
      "20 -- Panel radiator (two panels) without convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator21
      "21 -- Panel radiator (two panels) with one convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator22
      "22 -- Panel radiator (two panels) with two convection devices",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator30
      "30 -- Panel radiator (three panels) without convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator31
      "31 -- Panel radiator (three panels) with one convection device",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator32
      "32 -- Panel radiator (three panels) with two or more convection devices",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.ConvectorHeaterUncovered
      "Convector heater without cover",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.ConvectorHeaterCovered
      "Convector heater with cover",
    choice=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.Kermi_V_Plan_22
      "Kermi V-Plan Type 22"));
