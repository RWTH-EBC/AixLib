within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
block SelfShadowing
  "Self-shadowing due to projections for direct radiation"
  parameter Integer n(min = 1) "Number of windows"
    annotation(dialog(group="window"));
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Length b[n] "Width of window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Height h[n] "Height of window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length bLef[n] "Window projection left"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length bRig[n] "Window projection right"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length dLef[n]
    "Distance between projection (left) and window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length dRig[n]
    "Distance between projection (right) and window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length bAbo[n] "Window projection above"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length bBel[n] "Window projection below"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length dAbo[n]
    "Distance between projection (above) and window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Length dBel[n]
    "Distance between projection (below) and window"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Angle azi[n](displayUnit="degree") "Surface azimuth. azi=-90 degree if surface outward unit normal points
     toward east; azi=0 if it points toward south"
    annotation (Dialog(group="Window parameter"));
  parameter Modelica.Units.SI.Angle til[n](displayUnit="degree") "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for
    roof" annotation (Dialog(group="Window parameter"));

   Modelica.Blocks.Interfaces.RealInput incAng[n](
    final quantity="Angle",
    final unit="rad",
    displayUnit="degree")
    "Incidence angle of the sun beam on a tilted surface"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput solAzi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar Azimuth"
     annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput x_As[n](min=0,
    final unit="1") "Not shaded percentage of window area"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-8},{118,10}})));

protected
  Real e_hn[n] "Horizontal calculation factor";
  Real e_vn[n] "Vertical calculation factor";
  Modelica.Units.SI.Distance x1[n] "Auxiliary variable for shadow from left";
  Modelica.Units.SI.Distance x2[n] "Auxiliary variable for shadow from right";
  Modelica.Units.SI.Distance x3[n] "Auxiliary variable for shadow from above";
  Modelica.Units.SI.Distance x4[n] "Auxiliary variable for shadow from below";
  Modelica.Units.SI.Distance s_h[n] "Horizontal reduction of window";
  Modelica.Units.SI.Distance s_v[n] "Vertical reduction of window";
  Modelica.Units.SI.Area A_S[n] "Auxiliary variable for effective area";
  Modelica.Units.SI.Area A_s[n] "Effective windowarea";
equation
  for i in 1:n loop
  //Calculating e_hn and e_vn
    if Modelica.Math.cos(incAng[i])<=0 then
       e_hn[i]=10^20;
       e_vn[i]=10^20;
    else
      e_hn[i]=Modelica.Math.sin(
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
      azi[i])-
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
      solAzi))*Modelica.Math.cos(alt)/Modelica.Math.cos(incAng[i]);
      e_vn[i]=(Modelica.Math.sin(alt)*Modelica.Math.sin(
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
      til[i]))-Modelica.Math.cos(alt)*Modelica.Math.cos(
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
      til[i]))*Modelica.Math.cos(
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
      azi[i])-
      AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
      solAzi)))/Modelica.Math.cos(incAng[i]);
    end if;

  //Calculating s_h
  x1[i]=e_hn[i]*bLef[i]-dLef[i];
  x2[i]=-e_hn[i]*bRig[i]-dRig[i];
  if e_hn[i]>=0 then                          //Shadowing left
    if x1[i]<0 then                             //No shadow
      s_h[i]=0;
    elseif (e_hn[i]*bRig[i]+dRig[i])<0 then     //Additional shadow right
      s_h[i]=x1[i]-e_hn[i]*bRig[i]-dRig[i];
    else
      s_h[i]=x1[i];                             //Normal shadow left
    end if;
  else                                        //Shadowing right
    if x2[i]<0 then                             //No shadow
      s_h[i]=0;
    elseif (-e_hn[i]*bLef[i]+dLef[i])<0 then    //Additional shadow left
      s_h[i]=x2[i]+e_hn[i]*bLef[i]-dLef[i];
    else                                        //Normal shadow right
      s_h[i]=x2[i];
    end if;
  end if;
  //Calculating s_v
  x3[i]=e_vn[i]*bAbo[i]-dAbo[i];
  x4[i]=-e_vn[i]*bBel[i]-dBel[i];
  if e_vn[i]>=0 then                        //Shadowing above
    if x3[i]<0 then                            //No shadow
      s_v[i]=0;
    elseif (e_vn[i]*bBel[i]+dBel[i])<0 then    //Additional shadow below
      s_v[i]=x3[i]-e_hn[i]*bBel[i]-dBel[i];
    else                                       //Normal shadow above
      s_v[i]=x3[i];
    end if;
  else                                      //Shadowing below
    if x4[i]<0 then                            //No shadow
      s_v[i]=0;
    elseif (-e_vn[i]*bAbo[i]+dAbo[i])<0 then   //Additional shadow above
      s_v[i]=x4[i]-e_vn[i]*bAbo[i]-dAbo[i];
    else                                       //Normal shadow below
      s_v[i]=x4[i];
    end if;
  end if;
  //Calculating A_s
  if (b[i]-s_h[i])<0 then
     A_S[i]=0;
  elseif (h[i]-s_v[i])<0 then
     A_S[i]=0;
  else
     A_S[i]=(b[i]-s_h[i])*(h[i]-s_v[i]);
  end if;
  A_s[i] = max(0,A_S[i]);
  x_As[i]=A_s[i]/(b[i]*h[i]);
  end for;
     annotation (defaultComponentName="selfShadowing",
     Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Bitmap(extent={{-90,-98},{94,92}}, fileName=
              "modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/SelfShadowing.png")}),
                                                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model considers self-shadowing of windows due to projections for
  direct radiation based on VDI 6007 part 3. It calculates what part of
  the windowarea is effective.
</p>
<p>
  <img alt=\"SelfShadowing\" src=
  \"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/SelfShadowing.png\"
  height=\"400\">
</p>
<p>
  The image above shows how the parameters should be set and is based
  on VDI 6007 part 3. Parameters with Index 2 are alligned on the other
  side
</p>
<p>
  (i.e.: dRig is the distance between the projection and the window on
  the right handside, dBel is the distance between the projection below
  and the window). eh and ev are calculated within the model and are
  shown for demonstration.
</p>
<p>
  The connectors are all solar geometry dimensions and can be
  calculated by the SolarGeometry package of AixLib.
</p>
<p>
  An Example on how to use this model is the SelfShadowingExample in
  the Example package.
</p>
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  Modelling of solar radiation.
</p>
<ul>
  <li>May 23, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SelfShadowing;
