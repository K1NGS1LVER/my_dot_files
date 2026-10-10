#!/bin/bash

# Get page size and total memory
PAGE_SIZE=$(sysctl -n vm.pagesize)
MEM_TOTAL_BYTES=$(sysctl -n hw.memsize)

# Get page counts from vm_stat
VM_STAT=$(vm_stat)
PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
PAGES_COMPRESSED=$(echo "$VM_STAT" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

# Calculate used bytes (active + wired + compressed)
USED_BYTES=$(( ($PAGES_ACTIVE + $PAGES_WIRED + $PAGES_COMPRESSED) * PAGE_SIZE ))

# Convert to percentage
PCT=$(echo "scale=0; $USED_BYTES * 100 / $MEM_TOTAL_BYTES" | bc)

# Display as percentage
sketchybar --set ram label="${PCT}%"
