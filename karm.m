%% modeling the avoid/escape optimizaiton behavior with k-arm bandit model
n_arms = 7;
% 7 choices: exit @ 0/1/2/3/4/5/6 seconds
n_trials = 30;
n_steps = 30;
% rats usually goes through 30 sessions containing 30 trials

function [P_arm,Q_arm,N_arm] = initialize(n_arms, initialval)
        P_arm = rand(1,n_arms);
        Q_arm = ones(1,n_arms)*initialval;
        N_arm = zeros(1,n_arms);
end

function [action] = policy_egreedy(Q_arm,epsilon,n_arms)
        if rand(1)<epsilon
            pos = randi(length(n_arms));
            action = n_arms(pos);
        else
            [val,action] = max(Q_arm);
        end
end

function [action] = policy_UCB(t,Q_arm,c,N_arm,action)
        [val,action] = max(Q_arm+c+sqrt(log(t)/N_arm(action)));
end

for i = 1:n_trials
    [P_arm,Q_arm,N_arm] = initialize(n_arms,1)
    for i = 1:n_steps
        R_arm = 
    end
end

