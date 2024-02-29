import os
from assnake.core.Result import Result

result = Result.from_location(
    name='permanova_plot',
    description='PERMANOVA analysis plot.',
    result_type='analysis',
    input_type='phyloseq',
    with_presets=True,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))