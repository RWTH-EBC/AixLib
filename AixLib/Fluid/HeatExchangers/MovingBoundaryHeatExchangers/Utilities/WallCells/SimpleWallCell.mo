within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.WallCells;
model SimpleWallCell
  "Model of a wall cell of a moving boundary heat exchanger"
  extends BaseClasses.PartialWallCell;

  // Definition of variables describing thermodynamic states
  //
  Modelica.SIunits.Temperature TSC
    "Average temperature of the wall of the supercooled regime";
  Modelica.SIunits.Temperature TSCTP
    "Temperature of the wall at the boundary between supercooled and 
    two-phase regime";
  Modelica.SIunits.Temperature TTP
    "Average temperature of the wall of the two-phase regime";
  Modelica.SIunits.Temperature TTPSH
    "Temperature of the wall at the boundary between two-phase and 
    superheated regime";
  Modelica.SIunits.Temperature TSH
    "Average temperature of the wall of the superheated regime";

  // Defitinion of variables describing heat flows
  //
  Modelica.SIunits.HeatFlowRate Q_flow_SCPri
    "Heat flow rate between the supercooled regime and the wall of the 
    primary fluid";
  Modelica.SIunits.HeatFlowRate Q_flow_TPPri
    "Heat flow rate between the two-phase regime and the wall of the 
    primary fluid";
  Modelica.SIunits.HeatFlowRate Q_flow_SHPri
    "Heat flow rate between the superheated regime and the wall of the 
    primary fluid";

  Modelica.SIunits.HeatFlowRate Q_flow_SCSec
    "Heat flow rate between the supercooled regime and the wall of the 
    secondary fluid";
  Modelica.SIunits.HeatFlowRate Q_flow_TPSec
    "Heat flow rate between the two-phase regime and the wall of the 
    secondary fluid";
  Modelica.SIunits.HeatFlowRate Q_flow_SHSec
    "Heat flow rate between the uperheated regime and the wall of the 
    secondary fluid";

  // Definition of variables describing conservation of energy
  //
  Modelica.SIunits.Energy engWal
    "Current energy of the wall";
  Modelica.SIunits.Energy engWalInt
    "Current energy of the wall calculated by integration";
  Modelica.SIunits.Power Q_flow_tot
    "Total heat flow rate between the wall and surroundings";


initial equation
  if iniSteSta then
    /* Steady state initialisation */
    der(TSC) = 0;
    der(TTP) = 0;
    der(TSH) = 0;
  else
    /* Fixed temperature initisalisation */
    TSC = TSCIni;
    TTP = TTPIni;
    TSH = TSHIni;
  end if;

  // Initial equations of state variables describing conservation of energy
  //
  engWalInt = matHX.cpWal*matHX.dWal * geoCV.l*geoCV.ACroSecWalFloCha *
    (lenInl[1]*TSC + lenInl[2]*TTP + lenInl[3]*TSH)
    "Current energy of the wall calculated by integration";

equation
  // Connect variables with connectors
  //
  heatPortSCPri.T = TSC
    "Average temperature of the supercooled regime";
  heatPortTPPri.T = TTP
    "Average temperature of the two-phase regime";
  heatPortSHPri.T = TSH
    "Average temperature of the superheated regime";
  heatPortSCSec.T = TSC
    "Average temperature of the supercooled regime";
  heatPortTPSec.T = TTP
    "Average temperature of the two-phase regime";
  heatPortSHSec.T = TSH
    "Average temperature of the superheated regime";

  heatPortSCPri.Q_flow = Q_flow_SCPri
    "Heat flow rate between the supercooled regime and the wall of the 
    primary fluid";
  heatPortTPPri.Q_flow = Q_flow_TPPri
    "Heat flow rate between the two-phase regime and the wall of the 
    primary fluid";
  heatPortSHPri.Q_flow = Q_flow_SHPri
    "Heat flow rate between the superheated regime and the wall of the 
    primary fluid";
  heatPortSCSec.Q_flow = Q_flow_SCSec
    "Heat flow rate between the supercooled regime and the wall of the 
    secondary fluid";
  heatPortTPSec.Q_flow = Q_flow_TPSec
    "Heat flow rate between the two-phase regime and the wall of the 
    secondary fluid";
  heatPortSHSec.Q_flow = Q_flow_SHSec
    "Heat flow rate between the uperheated regime and the wall of the 
    secondary fluid";

  lenOut = lenInl
    "Transmissions of lengths of the control volumes";

  // Calculation of boundary temperatures
  //
  TSCTP = (lenInl[2]*TSC+lenInl[1]*TTP)/(lenInl[1]+lenInl[2])
    "Temperature of the wall at the boundary between supercooled and 
    two-phase regime";
  TTPSH = (lenInl[3]*TTP+lenInl[2]*TSH)/(lenInl[2]+lenInl[3])
    "Temperature of the wall at the boundary between two-phase and 
    superheated regime";

  // Calculation of energy balances depending on current flow state
  //
  if modCV==Types.ModeCV.SC then
    /* Supercooled regime */

    Q_flow_SCSec + Q_flow_SCPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[1]*der(TSC) + (TSC-TSCTP)*der(lenInl[1]))
      "Energy balance of the supercooled regime";
    der(TTP) = tauTem*(TSC-TTP)
      "Energy balance of the two-phase regime";
    der(TSH) = tauTem*(TSC-TSH)
      "Energy balance of the superheated regime";

  elseif modCV==Types.ModeCV.SCTP then
    /* Supercooled regime - Two-phase regime*/

    Q_flow_SCSec + Q_flow_SCPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[1]*der(TSC) + (TSC-TSCTP)*der(lenInl[1]))
      "Energy balance of the supercooled regime";
    Q_flow_TPSec+Q_flow_TPPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[2]*der(TTP) + (TSCTP-TTP)*der(lenInl[1]) +
      (TTP-TTPSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the two-phase regime";
    der(TSH) = tauTem*(TTP-TSH)
      "Energy balance of the superheated regime";

  elseif modCV==Types.ModeCV.TP then
    /* Two-phase regime */

    der(TSC) = tauTem*(TTP-TSC)
      "Energy balance of the supercooled regime";
    Q_flow_TPSec+Q_flow_TPPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[2]*der(TTP) + (TSCTP-TTP)*der(lenInl[1]) +
      (TTP-TTPSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the two-phase regime";
    der(TSH) = tauTem*(TTP-TSH)
      "Energy balance of the superheated regime";

  elseif modCV==Types.ModeCV.TPSH then
    /* Two-phase regime - Superheated regime */

    der(TSC) = tauTem*(TTP-TSC)
      "Energy balance of the supercooled regime";
    Q_flow_TPSec+Q_flow_TPPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[2]*der(TTP) + (TSCTP-TTP)*der(lenInl[1]) +
      (TTP-TTPSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the two-phase regime";
    Q_flow_SHSec+Q_flow_SHPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[3]*der(TSH) +
      (TTPSH-TSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the superheated regime";

  elseif modCV==Types.ModeCV.SH then
    /* Superheated regime */

    der(TSC) = tauTem*(TSH-TSC)
      "Energy balance of the supercooled regime";
    der(TTP) = tauTem*(TSH-TTP)
      "Energy balance of the two-phase regime";
    Q_flow_SHSec+Q_flow_SHPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[3]*der(TSH) +
      (TTPSH-TSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the superheated regime";

  elseif modCV==Types.ModeCV.SCTPSH then
    /* Supercooled regime - Two-phase regime - Superheated regime*/

    Q_flow_SCSec + Q_flow_SCPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[1]*der(TSC) + (TSC-TSCTP)*der(lenInl[1]))
      "Energy balance of the supercooled regime";
    Q_flow_TPSec+Q_flow_TPPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[2]*der(TTP) + (TSCTP-TTP)*der(lenInl[1]) +
      (TTP-TTPSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the two-phase regime";
    Q_flow_SHSec+Q_flow_SHPri =  matHX.cpWal*matHX.dWal * geoCV.l*
      geoCV.ACroSecWalFloCha * (lenInl[3]*der(TSH) +
      (TTPSH-TSH)*(der(lenInl[1])+der(lenInl[2])))
      "Energy balance of the superheated regime";

  else
    assert(false,"Unknown flow state! Check inputs!");
    TSC = TSCIni "Dummy value to succeed index reduction";
    TTP = TTPIni "Dummy value to succeed index reduction";
    TSH = TSHIni "Dummy value to succeed index reduction";

  end if;

  // Calculation of conservation of energy used for diagnostics
  //
  engWal = matHX.cpWal*matHX.dWal * geoCV.l*geoCV.ACroSecWalFloCha *
    (lenInl[1]*TSC + lenInl[2]*TTP + lenInl[3]*TSH)
    "Current energy of the wall";
  der(engWalInt) = Q_flow_tot
    "Current energy of the wall calculated by integration";
  Q_flow_tot =  Q_flow_SCPri + Q_flow_TPPri + Q_flow_SHPri +
    Q_flow_SCSec + Q_flow_TPSec + Q_flow_SHSec
    "Total heat flow rate between the wall and surroundings";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a model of a wall cell of a moving boundary heat exchanger.
It supports two types of heat exchanger, i.e. direct-current and counter-current
heat exchangers. Both types are modelled by connecting the heat ports
of a secondary fluid cell with the heat ports of the wall cell. Then, 
a direct-current heat exchanger is modelled by using the secondary cell's fluid
ports in design direction and a counter-current heat exchanger is modelled by
using the secondary cell's fluid poirt against design direction.<br/><br/>
Validation models are stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.WallCells\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.WallCells.</a>
</p>
<h4>Assumptions</h4>
<p>
Some assumptions are used while modelling the wall cell. These
assumptions are listed below:
</p>
<ul>
<li>
Considering the possibility of storing energy in the wall.
</li>
<li>
Assuming locally constant wall temperatures of each control
volume.
</li>
<li>
Assuming a constant density and specific heat capacity of the
wall's material.
</li>
</ul>
<p>
The general modelling approach is based on the publication presented by
Bonilla et al. (2015). Thus, detailed information of the modelling assumptions
as well as the derivation of the equations of the model are given in the
publication of Bonilla et al.. The temperatures at the boundaries between the
different control volumes are computed with a weighted mean approach presented
by Zhand and Zhang (2006). Since this approach does not hold for inactive
control volumes, it is completed by adding a first-order delay element.
This delay element drifts the temperature of the inactive control volume
towards the temperature of the control volume next to it. The corresponding 
approach is proposed by Sangi et al. (2015).
</p>
<h4>References</h4>
<p>
W.-J. Zhang and C.-L. Zhang (2006). 
<a href=\"https://dx.doi.org/10.1016/j.ijrefrig.2006.03.002\">
A generalizedmoving-boundarymodel for transient simulation of dry-expansion 
evaporators under larger disturbances.</a> In: <i>International Journal of
Refrigeration</i>, 29(7):1119–1127.
</p>
<p>
J. Bonilla, S. Dormido and F. E. Cellier (2015). 
<a href=\"https://dx.doi.org/10.1016/j.cnsns.2014.06.035\">
Switching moving boundary models for two-phase flow evaporators and condensers.</a> 
In: <i>Communications in Nonlinear Science and Numerical Simulation</i>, 
20(3):743–768.
</p>
<p>
R. Sangi, R. Jahangiri. F. Klasing. R. Streblow and D. M&uuml;ller (2015). 
<a href=\"https://www.ebc.eonerc.rwth-aachen.de/go/id/dncb/file/564606\">
Dynamic modeling and simulation of geothermal heat pump systems based on a 
combined moving boundary and discretized approach.</a> In: <i>14th International 
Conference of the International Building Performance Simulation Association</i>.
</p>
</html>"), Diagram(graphics={
        Rectangle(
          extent={{-90,20},{92,-20}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{80,-10},{-80,-10}},
          color={0,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=1),
        Text(
          extent={{-80,16},{80,-4}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="Thermal conductance inside of the simple wall
depending on the current control volumes")}));
end SimpleWallCell;
