function AC_RunEncoData = run_length(AC_Val)
    % Flatten the AC_Val matrix into a single vector
    AC_Vector = AC_Val(:);

    % Initialize variables
    currentVal = AC_Vector(1);
    currentRun = 0;
    AC_RunEncoData = [];

    % Perform run-length encoding
    for i = 1:length(AC_Vector)
        if AC_Vector(i) == currentVal
            currentRun = currentRun + 1;
        else
            % Append (run, level) pair to the encoded data
            AC_RunEncoData = [AC_RunEncoData, currentRun, currentVal];
            currentVal = AC_Vector(i);
            currentRun = 1;
        end
    end

    % Append the last (run, level) pair to the encoded data
    AC_RunEncoData = [AC_RunEncoData, currentRun, currentVal];
end
