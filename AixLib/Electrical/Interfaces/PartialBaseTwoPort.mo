within AixLib.Electrical.Interfaces;
 model PartialBaseTwoPort "Model of a generic two port component"
 
   replaceable AixLib.Electrical.Interfaces.BaseTerminal terminal_n
     "Electric terminal side p"
     annotation (Placement(transformation(extent={{-108,-8},{-92,8}})));
   replaceable AixLib.Electrical.Interfaces.BaseTerminal terminal_p
     "Electric terminal side n"
     annotation (Placement(transformation(extent={{92,-8},{108,8}})));
 
   annotation (Documentation(revisions="<html>
 <ul>
 <li>
 May 15, 2014, by Marco Bonvini:<br/>
 Created documentation.
 </li>
 </ul>
 </html>", info="<html>
 <p>
 This model declares connectors for electrical components with two terminals.
 </p>
 </html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
 end PartialBaseTwoPort;
