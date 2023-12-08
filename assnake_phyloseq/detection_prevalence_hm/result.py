import os
from assnake.core.Result import Result

result = Result.from_location(
    name='plot_detection_prevalence_heatmap',
    description='Plot a detection-prevalence heatmap for microbiome data.',
    result_type='plot',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))