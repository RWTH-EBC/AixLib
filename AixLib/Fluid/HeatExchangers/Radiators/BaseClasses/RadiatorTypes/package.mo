within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
package RadiatorTypes
  extends Modelica.Icons.VariantsPackage;

  // constants: ratio of radiative power as a fraction of total heat emission (taken from DIN EN 442-2, 2003),

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
