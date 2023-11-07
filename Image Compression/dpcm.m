function encodedDiff = dpcm(DC_Val)
    % Initialize the encoded differences array
    encodedDiff = zeros(size(DC_Val));
    
    % Apply DPCM coding to each row of the DC_Val matrix
    for i = 1:size(DC_Val, 1)
        % Initialize the predictor with the first value of the row
        predictor = DC_Val(i, 1);
        
        % Apply DPCM coding to the row
        for j = 1:size(DC_Val, 2)
            % Calculate the difference between the current value and the predictor
            difference = DC_Val(i, j) - predictor;
            
            % Update the predictor with the current value for the next iteration
            predictor = DC_Val(i, j);
            
            % Store the quantized difference in the encodedDiff matrix
            encodedDiff(i, j) = difference;
        end
    end
end
