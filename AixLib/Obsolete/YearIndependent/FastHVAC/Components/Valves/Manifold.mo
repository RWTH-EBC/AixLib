within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Valves;
model Manifold
extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Manifold Parameters
     ******************************************************************* */

parameter Integer n(min=1) = 1 "Number of input flows";

  /* *******************************************************************
      Components
     ******************************************************************* */

  Interfaces.EnthalpyPort_a enthalpyPort_a[n]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Interfaces.EnthalpyPort_b enthalpyPort_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));   //n-dimensional imput port // 1-dimensional output port

equation
     enthalpyPort_b.m_flow  =  sum(enthalpyPort_a.m_flow);  //mass balance
     enthalpyPort_b.m_flow*enthalpyPort_b.h = enthalpyPort_a.m_flow*enthalpyPort_a.h; //enthalpy balance
     enthalpyPort_b.c = enthalpyPort_a[1].c;  //cp remains unchanged
     enthalpyPort_b.h = enthalpyPort_b.c*enthalpyPort_b.T; //h=c*T

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={Polygon(
          points={{100,20},{20,20},{-20,60},{-100,60},{-100,60},{-100,40},{-30,
              40},{0,10},{-100,10},{-100,-10},{-96,-10},{0,-10},{-30,-40},{-100,
              -40},{-100,-60},{-20,-60},{20,-20},{100,-20},{100,-18},{100,20}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a manifold
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Collects the flow of the n input ports into one single output port.
  Input flows must be of the same medium (same density and specific
  heat capacity). The temperature and enthalpy of the output flow are
  obtained by balancing the mass and enthalpy flows.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Nicolás Chang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Manifold;
