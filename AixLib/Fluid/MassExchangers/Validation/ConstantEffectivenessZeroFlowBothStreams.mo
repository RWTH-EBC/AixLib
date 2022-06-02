within AixLib.Fluid.MassExchangers.Validation;
 model ConstantEffectivenessZeroFlowBothStreams
   "Zero flow test for constants effectiveness mass exchanger"
   extends AixLib.Fluid.MassExchangers.Examples.ConstantEffectiveness(
     PSin_1(
       height=0,
       offset=1E5),
     PIn(
       height=0,
       offset=101325));
   annotation (Documentation(revisions="<html>
 <ul>
 <li>
 May 7, 2018, by Michael Wetter:<br/>
 First implementation.
 See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/907\">#907</a>.
 </li>
 </ul>
 </html>", info="<html>
 <p>
 This model tests whether 
 <a href=\"modelica://AixLib.Fluid.MassExchangers.ConstantEffectiveness\">AixLib.Fluid.MassExchangers.ConstantEffectiveness</a>
 works correctly at zero flow if both streams are zero.
 </p>
 </html>"), experiment(Tolerance=1e-06, StopTime=1),
     __Dymola_Commands(file=
           "Resources/Scripts/Dymola/Fluid/MassExchangers/Validation/ConstantEffectivenessZeroFlowBothStreams.mos"
         "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
 end ConstantEffectivenessZeroFlowBothStreams;
