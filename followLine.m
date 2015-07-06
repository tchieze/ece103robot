function [state] = followLine(brick)
% Will require brick object as input argument once implemented into race

%robot start processes will be removed and done only once at race start
%address = '00165311686b'
%brick = lego.NXT(address)
%brick.getBatteryLevel() /9000

lightSensor = lego.NXT.IN_1;
%leftWheel = lego.NXT.OUT_A;
%rightWheel = lego.NXT.OUT_C;
%both wheels A and C together
wheels = lego.NXT.OUT_AC;

retVal = brick.setInputMode(lightSensor, 15, 0);
if retVal == 0
    fprintf('lolwut\n');
    brick.resetInputScaledValue(lightSensor);
end

% Approx light ranges on desktop -- may be different in race box
% all blue tape ~285-295
% mix ~330 - 360
% white ~450-460

% system pause before loop start

tic % start timer
steer = 0;
while toc < 8 % run for 15 seconds %change to test for red line
    senseValue = brick.sensorValue(lightSensor);
     steer = 0;
    if senseValue > 350
        steer = steer + 1;
    elseif senseValue < 335;
        steer = steer - 1;
    else
        steer = 0;
    end
    
    if steer > 100 
        steer = 100;
    elseif steer < -100
        steer = -100;
    end
    
    % Second argument is power, increase after testing
    brick.motorReverseSync(wheels,30,steer); 
    
    fprintf('Steer: %2.1f\n', steer);
    %fprintf('light: %2.1f\n', senseValue);
end

%close cmd need removed after implementation into race
brick.close();
