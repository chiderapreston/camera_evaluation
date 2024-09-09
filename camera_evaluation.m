% Main script to run the mock processes

% Initialize the world object
world = struct();
world.get_blueprint_library = @mock_get_blueprint_library;

% Call the evaluate_cameras function with the world object
selectedCameras = evaluate_cameras(world);

% Local Functions

function blueprints = mock_get_blueprint_library()
    % Simulate a blueprint library with different sensors
    blueprints = struct('id', {'sensor.camera.rgb', 'sensor.lidar.ray_cast', 'sensor.camera.depth'});
end

function selectedCameras = evaluate_cameras(world)
    % Ensure world is passed correctly and get blueprints
    blueprints = world.get_blueprint_library();
    cameras = filterBlueprints(blueprints, 'camera');
    
    selectedCameras = {};
    for i = 1:length(cameras)
        if evaluate_camera(cameras(i))
            selectedCameras{end+1} = cameras(i).id;
        end
    end
    
    disp('Selected Cameras:');
    disp(selectedCameras);
end

function isValid = evaluate_camera(camera)
    % Simple evaluation logic to check for a specific camera id
    isValid = strcmp(camera.id, 'sensor.camera.rgb');
end

function filtered = filterBlueprints(blueprints, keyword)
    % This function filters blueprints that contain the keyword in their id
    filtered = blueprints(contains({blueprints.id}, keyword));
end
