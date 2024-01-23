within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
model HeatTransferLambdaEff

//  import BufferStorage = BufferStorage2;
  extends PartialHeatTransferLayers;
  Modelica.Units.SI.HeatFlowRate[n - 1] Q_flow
    "Heat flow rate from segment i+1 to i";
  //Modelica.Thermal.HeatTransfer.TemperatureSensor[n] temperatureSensor
   // annotation 2;

protected
  parameter Real kappa=0.41 "Karman constant";
  parameter Modelica.Units.SI.Length height=data.hTank/n
    "height of fluid layers";
  Real beta=350e-6 "thermal expansion coefficient in 1/K";
  parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  parameter Modelica.Units.SI.Density rho=1000
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p=4180
    "Specific heat capacity";
                              //
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
  Real[n-1] k(unit="W/K") "effective heat transfer coefficient";
  Real[n-1] lambda(unit="W/mK") "effective heat conductivity";
  parameter Modelica.Units.SI.ThermalConductivity lambda_water=0.64;
equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    lambda[i]^2=noEvent(max((9.81*beta*dT[i]/height)*(2/3*rho*c_p*kappa*height^2)^2,0));
    k[i]=(noEvent(if dT[i]>0 then lambda[i] else 0)+lambda_water)*A/height;
    Q_flow[i] = k[i]*dT[i];
  end for;

//positiv heat flows here mean negativ heat flows for the fluid layers
  therm[1].Q_flow = Q_flow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = -Q_flow[i-1]+Q_flow[i];
  end for;
  therm[n].Q_flow = -Q_flow[n-1];
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat transfer between buffer storage layers. Models
  conductance of water and buoyancy according to Viskanta et al., 1997.
  An effective heat conductivity is therefore calculated. Used in
  BufferStorage model.
</p>
<h4>
  <span style=\"color:#008000\">Sources</span>
</h4>
<p>
  R. Viskanta, A. KaraIds: Interferometric observations of the
  temperature structure in water cooled or heated from above.
  <i>Advances in Water Resources,</i> volume 1, 1977, pages 57-69.
  Bibtex-Key [R.VISKANTA1977]
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 10, 2013</i> by Kristian Huchtemann:<br/>
    New implementation in source code. Documentation.
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransferLambdaEff;
