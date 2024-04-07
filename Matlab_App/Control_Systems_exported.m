classdef Control_Systems_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        ResetButton                    matlab.ui.control.Button
        TransferFunctionLabel_2        matlab.ui.control.Label
        TransferFunctionLabel          matlab.ui.control.Label
        GainSlider                     matlab.ui.control.Slider
        GainSliderLabel                matlab.ui.control.Label
        StartButton                    matlab.ui.control.Button
        DampingRatiozetaSlider         matlab.ui.control.Slider
        DampingRatiozetaSliderLabel    matlab.ui.control.Label
        NaturalFrequencyomega_nSlider  matlab.ui.control.Slider
        NaturalFrequencyomegaLabel     matlab.ui.control.Label
        UIAxes3                        matlab.ui.control.UIAxes
        UIAxes2                        matlab.ui.control.UIAxes
        UIAxes                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        k
        w
        d % Description
    end
    
    methods (Access = private)
        
        function results = func(app)
            
        end
        
        function results = func2(app)
            
        end
        
        function results = func3(app)
            
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button down function: UIAxes
        function step(app, event)
            
        end

        % Callback function
        function TransferFunctionEditFieldValueChanged(app, event)
            value = app.TransferFunctionEditField.Value;
            fprintf("%f",value);
            
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            app.k = 0;
            app.w = 0;
            app.d = 0;
            c = tf([app.k*((app.w)^2)],[1 2*(app.w)*(app.d) (app.w)^2]);
            app.TransferFunctionLabel.Text = ''; % Initialize the label with an empty string
            tfString = sprintf('%0.2f \n-----------------------------\n s² + %0.2fs + %0.2f',0, 2 * 0 * app.d, 0); 
            app.TransferFunctionLabel.Text = tfString; 
            step(app.UIAxes,c);
            pzmap(app.UIAxes2,c); 
            bode(app.UIAxes3,c);
            hold(app.UIAxes, 'on')
            % app.k=4;
            % step(app.UIAxes,c);
        end

        % Value changing function: GainSlider
        function GainSliderValueChanging(app, event)

            app.k = event.Value;
            c2 = tf([app.k*((app.w)^2)],[1 2*(app.w)*(app.d) (app.w)^2]);
            fprintf('k: %f, w: %f, d: %f\n', app.k, app.w, app.d);
            tfString = sprintf('%0.2f \n-----------------------------\n s² + %0.2fs + %0.2f',app.k * app.w^2, 2 * app.w * app.d, app.w^2); 
             % Update the Transfer Function label
             app.TransferFunctionLabel.Text = tfString; 
            % app.TransferFunctionTextField.Text = char(c);
            cla(app.UIAxes);  % Clear the axes before plotting
            cla(app.UIAxes2); 
            cla(app.UIAxes3);
            step(app.UIAxes, c2);
            pzmap(app.UIAxes2,c2);
            bode(app.UIAxes3,c2);

        end

        % Button down function: UIAxes3
        function UIAxes3ButtonDown(app, event)
            
        end

        % Value changing function: NaturalFrequencyomega_nSlider
        function NaturalFrequencyomega_nSliderValueChanging(app, event)
             app.w = event.Value;
            c2 = tf([app.k*((app.w)^2)],[1 2*(app.w)*(app.d) (app.w)^2]);
            fprintf('k: %f, w: %f, d: %f\n', app.k, app.w, app.d);
            tfString = sprintf('%0.2f \n-----------------------------\n s² + %0.2fs + %0.2f',app.k * app.w^2, 2 * app.w * app.d, app.w^2); 
             % Update the Transfer Function label
             app.TransferFunctionLabel.Text = tfString; 
            cla(app.UIAxes);  % Clear the axes before plotting
            cla(app.UIAxes2); 
            cla(app.UIAxes3);
            step(app.UIAxes, c2);
            pzmap(app.UIAxes2,c2);
            bode(app.UIAxes3,c2);

            
        end

        % Value changing function: DampingRatiozetaSlider
        function DampingRatiozetaSliderValueChanging(app, event)
            app.d = event.Value;
            c2 = tf([app.k*((app.w)^2)],[1 2*(app.w)*(app.d) (app.w)^2]);
            fprintf('k: %f, w: %f, d: %f\n', app.k, app.w, app.d);
            tfString = sprintf('%0.2f \n-----------------------------\n s² + %0.2fs + %0.2f',app.k * app.w^2, 2 * app.w * app.d, app.w^2); 
             % Update the Transfer Function label
             app.TransferFunctionLabel.Text = tfString; 
            cla(app.UIAxes);  % Clear the axes before plotting
            cla(app.UIAxes2); 
            cla(app.UIAxes3);
            step(app.UIAxes, c2);
            pzmap(app.UIAxes2,c2);
            bode(app.UIAxes3,c2);

            
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            app.GainSlider.Value = 0;
            app.NaturalFrequencyomega_nSlider.Value = 0;
            app.DampingRatiozetaSlider.Value = 0;
            tfString = sprintf('%0.2f \n-----------------------------\n s² + %0.2fs + %0.2f',0, 2 * 0 * app.d, 0); 
            app.TransferFunctionLabel.Text = tfString; 
            cla(app.UIAxes);  % Clear the axes before plotting
            cla(app.UIAxes2); 
            cla(app.UIAxes3);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0 1 1];
            app.UIFigure.Position = [100 100 819 604];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Step Response')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @step, true);
            app.UIAxes.Position = [28 328 353 255];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Pole-Zero Plot')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [438 328 348 255];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Bode Plot')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            zlabel(app.UIAxes3, 'Z')
            app.UIAxes3.ButtonDownFcn = createCallbackFcn(app, @UIAxes3ButtonDown, true);
            app.UIAxes3.Position = [38 38 344 244];

            % Create NaturalFrequencyomegaLabel
            app.NaturalFrequencyomegaLabel = uilabel(app.UIFigure);
            app.NaturalFrequencyomegaLabel.HorizontalAlignment = 'center';
            app.NaturalFrequencyomegaLabel.FontName = 'Andale Mono';
            app.NaturalFrequencyomegaLabel.FontSize = 13;
            app.NaturalFrequencyomegaLabel.Interpreter = 'tex';
            app.NaturalFrequencyomegaLabel.Position = [490 121 155 22];
            app.NaturalFrequencyomegaLabel.Text = 'Natural Frequency \omega_n ';

            % Create NaturalFrequencyomega_nSlider
            app.NaturalFrequencyomega_nSlider = uislider(app.UIFigure);
            app.NaturalFrequencyomega_nSlider.ValueChangingFcn = createCallbackFcn(app, @NaturalFrequencyomega_nSliderValueChanging, true);
            app.NaturalFrequencyomega_nSlider.Position = [647 140 150 3];

            % Create DampingRatiozetaSliderLabel
            app.DampingRatiozetaSliderLabel = uilabel(app.UIFigure);
            app.DampingRatiozetaSliderLabel.HorizontalAlignment = 'right';
            app.DampingRatiozetaSliderLabel.Interpreter = 'tex';
            app.DampingRatiozetaSliderLabel.Position = [517 50 112 22];
            app.DampingRatiozetaSliderLabel.Text = 'Damping Ratio \zeta';

            % Create DampingRatiozetaSlider
            app.DampingRatiozetaSlider = uislider(app.UIFigure);
            app.DampingRatiozetaSlider.Limits = [0 1];
            app.DampingRatiozetaSlider.ValueChangingFcn = createCallbackFcn(app, @DampingRatiozetaSliderValueChanging, true);
            app.DampingRatiozetaSlider.Position = [648 69 150 3];

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [579 253 100 23];
            app.StartButton.Text = 'Start';

            % Create GainSliderLabel
            app.GainSliderLabel = uilabel(app.UIFigure);
            app.GainSliderLabel.HorizontalAlignment = 'right';
            app.GainSliderLabel.Interpreter = 'tex';
            app.GainSliderLabel.Position = [591 189 35 22];
            app.GainSliderLabel.Text = 'Gain';

            % Create GainSlider
            app.GainSlider = uislider(app.UIFigure);
            app.GainSlider.ValueChangingFcn = createCallbackFcn(app, @GainSliderValueChanging, true);
            app.GainSlider.Position = [646 208 150 3];

            % Create TransferFunctionLabel
            app.TransferFunctionLabel = uilabel(app.UIFigure);
            app.TransferFunctionLabel.HorizontalAlignment = 'center';
            app.TransferFunctionLabel.Position = [393 164 170 86];
            app.TransferFunctionLabel.Text = 'TransferFunction';

            % Create TransferFunctionLabel_2
            app.TransferFunctionLabel_2 = uilabel(app.UIFigure);
            app.TransferFunctionLabel_2.HorizontalAlignment = 'center';
            app.TransferFunctionLabel_2.FontName = 'American Typewriter';
            app.TransferFunctionLabel_2.FontSize = 15;
            app.TransferFunctionLabel_2.FontWeight = 'bold';
            app.TransferFunctionLabel_2.Position = [407 253 144 22];
            app.TransferFunctionLabel_2.Text = 'Transfer Function';

            % Create ResetButton
            app.ResetButton = uibutton(app.UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.Position = [705 253 100 23];
            app.ResetButton.Text = 'Reset';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Control_Systems_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end