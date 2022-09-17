function [Mdl, metric] = fitting(protocol_folder_abs_path, database_train_noisy, database_test_noisy, params_train, params_test)
    Mdl = train_RF_matlab(database_train_noisy, params_train, 200); % 200 trees
    
    % Mean Absolute Error per param
    MAE = [0,0,0,0,0];
    for i=1:5
        pred = predict(Mdl{i},database_test_noisy);
        target = params_test(:,i);
        
        if i == 1 || i == 2                
            pred = cos(pred).^2;
            target = cos(target).^2;
        end
        
        writematrix(pred, fullfile(protocol_folder_abs_path, [num2str(i) '_pred_param.txt']));
        writematrix(target, fullfile(protocol_folder_abs_path, [num2str(i) '_target_param.txt']));

        MAE(i) = mean(abs(pred-target));
    end
    
    metric = MAE(1)*0.35+MAE(2)*0.35+MAE(3)*0.1+MAE(4)*0.1+MAE(5)*0.1;
end
