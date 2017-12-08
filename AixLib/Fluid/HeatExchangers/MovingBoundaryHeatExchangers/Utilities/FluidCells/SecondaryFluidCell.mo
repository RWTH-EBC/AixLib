within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.FluidCells;
model SecondaryFluidCell
  "Model of a cell of a moving boundary heat exchanger's secondary fluid"
  extends BaseClasses.PartialSecondaryFluidCell;



  // Definition of models describing the calculation of heat transfers
  //
  CoefficientOfHeatTransferSC coefficientOfHeatTransferSC(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the supercooled regime"
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  CoefficientOfHeatTransferTP coefficientOfHeatTransferTP(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the two-phase regime"
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  CoefficientOfHeatTransferSH coefficientOfHeatTransferSH(
    geoCV=geoCV) if useHeaCoeMod
    "Coefficient of heat transfer of the superheated regime"
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));


equation
  // Calculation of coefficients of heat transfers
  //
  if not useHeaCoeMod then
    AlpThrSC = AlpSC
    "Connect coefficient of heat transfer of supercooled regime given by
    parameter";
    AlpThrTP = AlpTP
    "Connect coefficient of heat transfer of two-phase regime given by
    parameter";
    AlpThrSH = AlpSH
    "Connect coefficient of heat transfer of superheated regime given by
    parameter";
  end if;

  connect(AlpThrSC,coefficientOfHeatTransferSC.Alp)
    "Connect coefficient of heat transfer of supercooled regime calculated by
    model";
  connect(AlpThrTP,coefficientOfHeatTransferTP.Alp)
    "Connect coefficient of heat transfer of two-phase regime calculated by
    model";
  connect(AlpThrSH,coefficientOfHeatTransferSH.Alp)
    "Connect coefficient of heat transfer of superheated regime calculated by
    model";

//   UIntSC = AlpThrSC
//     "Transmission of coefficient of heat transfer of supercooled regime";
//   UIntTP = AlpThrTP
//     "Transmission of coefficient of heat transfer of two-phase regime";
//   UIntSH = AlpThrSH
//     "Transmission of coefficient of heat transfer of superheated regime";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a model of the secondary fluid of a moving
boundary heat exchanger.
<p>
<h4>Assumptions</h4>
<h4>Equations</h4>
<h4>References</h4>
</html>"));
end SecondaryFluidCell;
