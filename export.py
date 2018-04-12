import os
import shutil
import sys

BLACKLIST = shutil.ignore_patterns(".git*", "Plaintext Scripts*","*.py", "Randomizer.nfo", "MarkerNames.txt", "README.md")

if os.path.exists("Randomizer.gro"):
  print("Removing existing .gro")
  os.remove("Randomizer.gro")

print("Copying files")
shutil.copytree(os.path.dirname(sys.argv[0]), "temp/Content/Talos/Levels/Randomizer", ignore=BLACKLIST)
shutil.copy2("Randomizer.nfo", "temp/Content/Talos/Levels/Randomizer.nfo")
print("Zipping")
shutil.make_archive("Randomizer", 'zip', "temp")
shutil.move("Randomizer.zip", "Randomizer.gro")
print("Removing temp directory")
shutil.rmtree("temp")