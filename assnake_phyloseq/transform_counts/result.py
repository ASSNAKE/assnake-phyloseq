import os
from assnake.core.Result import Result

result = Result.from_location(
    name='transform-counts',
    description='Transform counts in a phyloseq object using microbiome package.',
    result_type='phyloseq',
    input_type='phyloseq',
    with_presets=False,
    preset_file_format='yaml',
    location=os.path.dirname(os.path.abspath(__file__)))
