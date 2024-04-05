within AixLib.Airflow.WindowVentilation.OpeningAreas;
model OpeningAreaSashVDI2078
  "Specified VDI 2078: Bottom-hung inwards opening, input port opening width"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialOpeningAreaSash(
    final useInputPort=true,
    final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    redeclare final Modelica.Blocks.Interfaces.RealInput u_win(
      quantity="Length", unit="m", min=0));
  parameter Modelica.Units.SI.Height winRevFraH = 0.1
    "Distance between the windows reveal and frame";
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth";
  Modelica.Units.SI.Height H_eff(min=0) "Effective height for the thermal updraft";
protected
  Modelica.Units.SI.Height H_ovl(min=0)
    "Height of the overlap between window frame and casement";
  Real C_Rev "Correction factor of the window reveal";
equation
  opnWidth = u_win;
  opnAngle = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
      winClrW, winClrH, opnWidth);
  assert(opnAngle <= Modelica.Units.Conversions.from_deg(15),
    "The model only applies to a maximum tilt angle of 15°",
    AssertionLevel.warning);
  A = ((winClrW + winClrH - H_ovl)*opnWidth/3)*C_Rev;
  H_eff = 2/3*(winClrH - H_ovl);
  H_ovl = winSashD/(opnWidth + winSashD)*winClrH;
  C_Rev = if opnWidth <= winRevFraH then 1
    else 1 - 0.6*(1 - winRevFraH/opnWidth);
  annotation (Icon(graphics={
        Text(
          extent={{-100,-100},{100,-60}},
          textColor={0,0,0},
          textString="VDI 2078")}),
                                Documentation(revisions="<html>
<ul>
  <li>
    <i>April 3, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model determines the window opening area according to VDI 2078:2015-06.</p>
<p>Only bottom-hung openings can be applied.</p>
<p>Input port of this model is the opening width.</p>
</html>"));
end OpeningAreaSashVDI2078;
