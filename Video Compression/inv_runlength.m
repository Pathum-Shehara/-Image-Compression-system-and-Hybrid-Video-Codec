function AC_Val = inv_runlength(AC_RunData)
    % Initialize an empty vector to store the inverse run-length encoded AC values
    AC_Val = [];
    
    % Iterate over the run-length encoded data
    for i = 1:2:length(AC_RunData)
        % Retrieve the run and level values from the encoded data
        run = AC_RunData(i);
        level = AC_RunData(i+1);
        
        % Repeat the level value 'run' times and append to the AC values
        AC_Val = [AC_Val, repmat(level, 1, run)];
    end
end