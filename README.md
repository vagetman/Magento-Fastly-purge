# Magento-Fastly-purge
A single object purge for fastly-magento module

When debugging/developing Magento site on Fastly, sometime there is a need to purge a signle object. The Fastly VCL module locks up single purges, requiring a signature header X-Purge-Token. The shell script generates the header based on service ID and the URL, then using curl to issue the PURGE command to Fastly.
