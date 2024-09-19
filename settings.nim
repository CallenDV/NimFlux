import json

type
  Settings* = ref object
    data: JsonNode

proc newSettings*(): Settings =
  result = Settings()
  result.data = %*{
    "homepage": "https://search.brave.com",
    "searchEngine": "https://www.google.com/search?q=",
    "enableJavaScript": true,
    "enableCookies": true
  }

proc loadSettings*(self: Settings, filename: string) =
  try:
    self.data = parseJson(readFile(filename))
  except:
    echo "Error loading settings, using defaults"

proc saveSettings*(self: Settings, filename: string) =
  try:
    writeFile(filename, $self.data)
  except:
    echo "Error saving settings"

proc getSetting*(self: Settings, key: string): JsonNode =
  self.data[key]

proc setSetting*(self: Settings, key: string, value: JsonNode) =
  self.data[key] = value