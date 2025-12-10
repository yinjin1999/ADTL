Dynamic constrained multiobjective optimization problems (DCMOPs) are characterized by objective functions and constraints that change complexly over time.
This time-varying characteristic proposes significant challenges for existing optimization algorithms, 
particularly in rapidly tracking the dynamic feasible regions and accurately converging to the changing Dynamic Constrained Pareto Optimal Front (DCPOF). 
To address the above challenges, an adaptive decomposition-basedtransfer learning method is proposed in this article, termed ADTL. 
The methodintroduces an adaptive objective space decomposition strategy to locate the dynamic feasible regions accurately. 
Upon the detection of a new environment, the objective space is decomposed by the historical optimal solutions. 
To efficiently track the DCPOF, an individual-based transfer learning strategy is proposed, which associates each solution in the current environment with its nearest reference vector. 
Then, a single-layer autoencoder is employed to learn the features of historical optimal solutions and transfer historical knowledge to the current population. 
Furthermore, to improve search efficiency, a diversity and feasibility enhancement strategyis proposed.
This strategy evaluates the diversity and feasibility of the predicted population, introduces random solutions according to the diversity level, and relocates infeasible
solutions to the boundary of the feasible regions. 
Comprehensive experiments on widely used benchmark problems demonstrate that the proposed algorithm is highly competitive in dealing with DCMOPs when compared with seven state-of-the-art algorithms.
