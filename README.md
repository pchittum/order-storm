# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

#Notes
Some things:

- Platform event partition key:
  - unique partition key values will create a random/semi-random distribution among parallel subs (semirandom because UUIDs are not guaranteed to be unique)
  - Sequential events with the same partition key value will be processed in order within a given partition
- Setup running user for subscriber to be able to run `log tail` as this user. Not a prod configuration necessarily.
- Setup PE enhanced usage metrics here: https://developer.salesforce.com/docs/atlas.en-us.256.0.api_meta.meta/api_meta/meta_platformeventsettings.htm
  - good to dig further into using these and working with this data
- Like many configurations that have broad impact, repartitioning is async and takes time. You can't just flip back and forth (give it a few seconds)
- Keep in mind, the tests aren't representative of performance you'd expect
  - How I'm tracing is specific to this implementation. I've tried to minimize performance impact, profiling always incurs some additional performance hit
  - Scratch org versus production/full sandbox. I imagine how Salesforce prioritises/allocates resources for some orgs is different from others...
  - **But** all tests are under the same conditions, so comparatively, I think we can still learn something generally with how these things perform.

Some thoughts on what to cover.

- Intro
  - everything async in the platform and apex (that could be a lot!)
  - Why zeroing in on Queueable and PEs?
  - What's the difference?
  - Some bits from architect.salesforce.com about usage, bet practices, etc. of each (this will include when to use)
  - Also, when _not_ to use async.
- Top to bottom of platform events configs (what can you control/config/tweak/finetune)
  - subscriber config metadata
  - Is there any publisher config??? yeah...probably not
-
