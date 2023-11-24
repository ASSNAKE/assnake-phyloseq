
import os
from assnake.core.Result import Result

result = Result.from_location(name='create-phyloseq',
                              description='Create phyloseq object from provided otu and taxa rds files',
                              result_type='phyloseq',
                              input_type='feature_table',
                              with_presets=False,
                              preset_file_format='yaml',
                              location=os.path.dirname(os.path.abspath(__file__)))
