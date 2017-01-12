function [ ] = print_results( Num_students, Num_items, result_theta, result_a, result_b, result_c, iterator)
%PRINT_RESULTS Summary of this function goes here
%   Detailed explanation goes here

    % theta param

    figure;
    hold on
    for i = 1:Num_students
        plot(result_theta(:,i));

    end
    xlabel('iterations number');
    ylabel('estimator');
    titleDesc = sprintfc('Theta Estimator Graph %d', iterator);
    title(titleDesc);
    legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');

    % a param

    figure;
    hold on
    for i = 1:Num_items
        plot(result_a(:,i));

    end
    xlabel('iterations number');
    ylabel('estimator');
    titleDesc = sprintfc('a Estimator Graph %d', iterator);
    title(titleDesc);
    legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');

    % b param
    figure;
    hold on
    for i = 1:Num_items
        plot(result_b(:,i));

    end
    xlabel('iterations number');
    ylabel('estimator');
    titleDesc = sprintfc('b Estimator Graph %d', iterator);
    title(titleDesc);
    legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');

    % c param
    figure;
    hold on
    for i = 1:size(result_c,2)
        plot(result_c(:,i));

    end
    xlabel('iterations number');
    ylabel('estimator');
    titleDesc = sprintfc('c Estimator Graph %d', iterator);
    title(titleDesc);
    legend('1','2','3','4','5','6','7','8','9','10','Location','northwest');
    
    %{
    subplot(2,1,1);
    plot(result_a(:,1));
    xlabel('iterations number')
    ylabel('estimator');

    subplot(2,1,2);
    plot(result_a(:,2));
    xlabel('iterations number')
    ylabel('estimator');
    %}
end