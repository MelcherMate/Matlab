classdef Zomok_D_MatlabIntroduction_ExerciseNr29_wt25 < matlab.apps.AppBase
    
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        UIAxes                      matlab.ui.control.UIAxes
        OpenDataButton              matlab.ui.control.Button
        ExecuteButton               matlab.ui.control.Button
        DataProcessingButtonGroup   matlab.ui.container.ButtonGroup
        LinearButton                matlab.ui.control.RadioButton
        SplineButton                matlab.ui.control.RadioButton
        MovingAvButton              matlab.ui.control.RadioButton
    end
    
    properties (Access = private)
        xData   double
        yData   double
        RawPlotHandle
        ProcessedPlotHandle
    end
    
    methods (Access = private)
        
        function loadData(app)
            [file, path] = uigetfile({'*.xlsx','Excel Files (*.xlsx)'}, ...
                                     'Select DATA_for_EXERCISES.xlsx');
            if isequal(file, 0)
                return;
            end
            
            filename = fullfile(path, file);
            T = readtable(filename, 'Sheet', 'noisy_data');
            
            app.xData = T.x;
            app.yData = T.noisy;
            
            finiteIdx = isfinite(app.xData) & isfinite(app.yData);
            app.xData = app.xData(finiteIdx);
            app.yData = app.yData(finiteIdx);
            
            [app.xData, sortIdx] = sort(app.xData);
            app.yData = app.yData(sortIdx);
            
            cla(app.UIAxes);
            app.RawPlotHandle = plot(app.UIAxes, app.xData, app.yData, ...
                                     'o', 'DisplayName', 'Raw Data');
            grid(app.UIAxes, 'on');
            xlabel(app.UIAxes, 'x');
            ylabel(app.UIAxes, 'noisy');
            title(app.UIAxes, 'Data Processing');
            legend(app.UIAxes, 'show');
            
            if ~isempty(app.ProcessedPlotHandle) && isvalid(app.ProcessedPlotHandle)
                delete(app.ProcessedPlotHandle);
            end
        end
        
        function executeProcessing(app)
            if isempty(app.xData)
                uialert(app.UIFigure, ...
                        'Please load the Excel file first.', ...
                        'No Data');
                return;
            end
            
            selected = app.DataProcessingButtonGroup.SelectedObject;
            
            if ~isempty(app.ProcessedPlotHandle) && isvalid(app.ProcessedPlotHandle)
                delete(app.ProcessedPlotHandle);
            end
            
            if selected == app.LinearButton
                yProcessed = interp1(app.xData, app.yData, app.xData, 'linear');
            elseif selected == app.SplineButton
                yProcessed = interp1(app.xData, app.yData, app.xData, 'spline');
            elseif selected == app.MovingAvButton
                yProcessed = smoothdata(app.yData, 'movmean', 10);
            else
                yProcessed = app.yData;
            end
            
            hold(app.UIAxes, 'on');
            app.ProcessedPlotHandle = plot(app.UIAxes, app.xData, yProcessed, ...
                                           'r-', 'LineWidth', 1.5, ...
                                           'DisplayName', 'Processed Data');
            legend(app.UIAxes, 'show');
            hold(app.UIAxes, 'off');
        end
    end
    
    methods (Access = private)
        function OpenDataButtonPushed(app, ~)
            loadData(app);
        end
        
        function ExecuteButtonPushed(app, ~)
            executeProcessing(app);
        end
    end
    
    methods (Access = public)
        function app = Zomok_D_MatlabIntroduction_ExerciseNr29_wt25
            createComponents(app);
        end
    end
    
    methods (Access = private)
        function createComponents(app)
            app.UIFigure = uifigure('Position', [100 100 600 400], ...
                                    'Name', 'Exercise 29');
            
            app.UIAxes = uiaxes(app.UIFigure, 'Position', [25 75 400 300]);
            title(app.UIAxes, 'Data Processing');
            xlabel(app.UIAxes, 'x');
            ylabel(app.UIAxes, 'noisy');
            grid(app.UIAxes, 'on');
            
            app.OpenDataButton = uibutton(app.UIFigure, 'push', ...
                'Text', 'Open Datafile', ...
                'Position', [25 25 100 30], ...
                'ButtonPushedFcn', @(btn, event) OpenDataButtonPushed(app, event));
            
            app.ExecuteButton = uibutton(app.UIFigure, 'push', ...
                'Text', 'Execute', ...
                'Position', [150 25 100 30], ...
                'ButtonPushedFcn', @(btn, event) ExecuteButtonPushed(app, event));
            
            app.DataProcessingButtonGroup = uibuttongroup(app.UIFigure, ...
                'Title', 'Data Processing', ...
                'Position', [450 100 120 150]);
            
            app.LinearButton = uiradiobutton(app.DataProcessingButtonGroup, ...
                'Text', 'Linear', ...
                'Position', [10 100 100 20], ...
                'Value', true);
            
            app.SplineButton = uiradiobutton(app.DataProcessingButtonGroup, ...
                'Text', 'Spline', ...
                'Position', [10 70 100 20]);
            
            app.MovingAvButton = uiradiobutton(app.DataProcessingButtonGroup, ...
                'Text', 'MovingAv', ...
                'Position', [10 40 100 20]);
        end
    end
end
