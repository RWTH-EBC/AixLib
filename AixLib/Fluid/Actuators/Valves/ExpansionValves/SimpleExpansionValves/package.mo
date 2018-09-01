within AixLib.Fluid.Actuators.Valves.ExpansionValves;
package SimpleExpansionValves "Package that contains simple expansion valves"
  extends Modelica.Icons.VariantsPackage;






  model ExpansionValveModified "Model with metastability degree"
   extends BaseClasses.PartialIsenthalpicExpansionValve;

  //Variables for metastability degree

  Modelica.SIunits.Pressure p_th
    "Pressure at throat";
  Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
      Real C_meta "Degree of metastability";


      parameter Utilities.Types.Choice Choice=Utilities.Types.Choice.Bernoullip_th
      "1:m_flow (Pinl,pOut); 2:m_flow(pInl,p_th)";


  replaceable model MetastabilityCoefficient =
     Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.ConstantMetastabilityCoefficient
       constrainedby BaseClasses.Coefficient.PartialMetastabilityCoefficient
       "Model that describes the calculation of the metastability coefficient"
        annotation (choicesAllMatching=true, Dialog(enable=if (Utilities.Types.Choice.ExpansionsValve or Utilities.Types.Choi)
             then true else false,
        tab="MetastabilityCoefficient",
        group="MetastabilityCoefficient model"));

     MetastabilityCoefficient metastabilitycoefficient(
      redeclare package Medium = Medium,
      opening=opening,
      AVal=AVal,
      dInlPip=dInlPip,
      staInl=staInl,
      staOut=staOut,
      pInl=pInl,
      pOut=pOut) "Instance of model 'Metastability Coefficient'";
    //annotation(HideResult = (if show_flow_coefficient then false else true));


  equation


    satInl = Medium.setSat_T(Medium.temperature(staInl))
        "Saturation properties at valve's inlet conditions";

  //
  //Bernoulli with Metastability Coefficient
    if (Choice == Utilities.Types.Choice.Bernoullip_th) then
      m_flow^2 = C^2*AThr^2*(2*Medium.density(staInl)*(pInl - p_th));
      p_th = metastabilitycoefficient.p_th;
      //C = flowCoefficient.C;
      C=0.95;
        C_meta = metastabilitycoefficient.C_meta
       "Degree of metastability";


      //
  //Bernoulli equation
  elseif (Choice == Utilities.Types.Choice.ExpansionValve) then

      m_flow^2 = AThr^2*C^2*(2*Medium.density(staInl)*(pInl - pOut));
      p_th =  1;
    //  C = flowCoefficient.C;
    C=0.95;
    C_meta = 0.5;

    else
      assert(false, "Invalid choice of calculation procedure");
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ExpansionValveModified;

annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains models describing simple expanion valves.
</p> 
</html>"));
end SimpleExpansionValves;
