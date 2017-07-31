# cell-cycle-chromatin

### Script descriptions
- **get_binned_counts.sh**
  - Get counts in each bin using windows file provided from commandline
  - Usage: `./get_binned_counts.sh <bamdir> <windows> <outdir>`
  
- **cluster_intersect.sh**
  - Intersect with tss table

- **region_intersect.sh**
  - Intersect with regions.txt (produced from Homer) and then with ToR clusters
  
- **cluster_sum.sh**
  - Intersect with ToR clusters
