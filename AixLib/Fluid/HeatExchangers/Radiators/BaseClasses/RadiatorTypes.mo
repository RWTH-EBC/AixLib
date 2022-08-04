within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
package RadiatorTypes
  extends Modelica.Icons.TypesPackage;

  // constants: ratio of radiative power as a fraction of total heat emission (taken from DIN EN 442-2, 2003),

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
  constant Real[2] SectionalRadiator={0.30,1};
  constant Real[2] PanelRadiator10={0.50,1};
  constant Real[2] PanelRadiator11={0.35,1.9};
  constant Real[2] PanelRadiator12={0.25,2.8};
  constant Real[2] PanelRadiator20={0.35,2.1};
  constant Real[2] PanelRadiator21={0.20,3.3};
  constant Real[2] PanelRadiator22={0.15,4.5};
  constant Real[2] PanelRadiator30={0.20,3.7};
  constant Real[2] PanelRadiator31={0.15,4.8};
  constant Real[2] PanelRadiator32={0.10,6.7};
  constant Real[2] PanelRadiator33={0.10,7.9};
                                               // extrapolated convective surface ( used surface increase of 1.2 - Peter Mathes)
  // also more convection devices
  constant Real[2] ConvectorHeaterUncovered={0.05,1};
  constant Real[2] ConvectorHeaterCovered={0.00,1};
  constant Real[2] ThermX2Typ10={0.5,1};
  constant Real[2] ThermX2Typ11={0.35,1};
  constant Real[2] ThermX2Typ12={0.3,1};
  constant Real[2] ThermX2Typ22={0.3,1};
  constant Real[2] ThermX2Typ33={0.2,1};

// protected

end RadiatorTypes;
