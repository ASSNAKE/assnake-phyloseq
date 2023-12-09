import os
from assnake.core.Result import Result

result = Result.from_location(
    name='ordination_plot',
    description='Plot ordination diagram.',
    result_type='plot',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))
