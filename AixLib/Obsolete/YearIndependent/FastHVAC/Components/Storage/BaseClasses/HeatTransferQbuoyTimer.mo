within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
model HeatTransferQbuoyTimer

//  import BufferStorage = BufferStorage2;
   extends
    AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.PartialHeatTransferLayers;
  Modelica.Units.SI.HeatFlowRate[n - 1] Q_flow
    "Heat flow rate from segment i+1 to i";

  //Modelica.Thermal.HeatTransfer.TemperatureSensor[n] temperatureSensor
   // annotation 2;
Real timer(start=tau);
protected
  parameter Modelica.Units.SI.Length height=data.hTank/n
    "height of fluid layers";
  parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
  parameter Modelica.Units.SI.ThermalConductivity lambda_water=0.64;
  parameter Modelica.Units.SI.Density rho=1000
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.Time tau=60;
  parameter Modelica.Units.SI.Time tau_refresh=900;
  Modelica.Units.SI.HeatFlowRate Q_buoy[n](start=zeros(n));
  Modelica.Units.SI.SpecificEnergy q_buoy[n];
      function isBuoy =
      AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions.isBuoy;

equation
  q_buoy =
    AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions.qbuoyTotal(
    n, therm.T);

der(timer)=-1;
der(Q_buoy)=zeros(n);

when timer<0 then

  if isBuoy(n,therm.T) then
    reinit(timer, tau);
    reinit(Q_buoy,q_buoy*A*rho*height/tau);
  else
    reinit(timer, tau_refresh);
    reinit(Q_buoy,zeros(n));
  end if;

end when;

//   if isBuoy(n, therm.T) and timer<0 then
//
//     Q_buoy= q_buoy*A*rho*height/tau;
//   else
//     Q_buoy=zeros(n);

//   end if;

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    Q_flow[i] = lambda_water*A/height*dT[i];

  end for;

// positive heat flows here mean negativ heat flows for the fluid layers
   therm[1].Q_flow =Q_flow[1] -Q_buoy[1];
   for i in 2:n-1 loop
        therm[i].Q_flow =-Q_flow[i-1]+Q_flow[i] -Q_buoy[i];
   end for;
   therm[n].Q_flow =-Q_flow[n-1] -Q_buoy[n];

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat transfer between buffer storage layers. Models
  conductance of water. Buoyancy and conduction are considered
  individually. Similar to HeatTransferQbuoy but extended by a fixed
  time period in which a check is performerd if a buoyancy layers
  exists.
</p>
<h4>
  <span style=\"color:#008000\">Sources</span>
</h4>
<p>
  Equations and parameters for calculating the buoyancy heatflow are
  empirically and derived by CFD simulations. The buoyancy is split up
  into three parts: Freebuoy, Botmix, Topmix.
</p>
<ul>
  <li>Freebuoy: Desribes the heatflow which is transfered directly by
  the upflowing mass to the overlying layers.
  </li>
  <li>Botmix and Topmix: Describes the heat that is transfered due to
  the mixing of the layers above and below the buoyancy layer that is
  induced by the upflowing mass
  </li>
</ul>
<p>
  Model was developed by Christian Grozescu in his master thesis
  <i>Extension of Thermal Storage Models for Energy System
  Simulations</i>, 2017
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>October 19, 2017&#160;</i> David Jansen:<br/>
    Added informations and commentations to source code and changed
    names according to AixLib regulations
  </li>
  <li>
    <i>March , 2017&#160;</i> Christian Grozescu :<br/>
    Developed model
  </li>
</ul>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end HeatTransferQbuoyTimer;
