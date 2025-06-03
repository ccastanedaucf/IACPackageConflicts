Min repro of a package downgrade which would normally appear as:
```

error NU1109: Detected package downgrade: ...
```

...passing through NuGet restore and being hit in RAR:

```
 MSB3277: There was a conflict between <package-1> and <package-2>
```


Note this seems to be *very* specific the project structure demonstrated here, where:
- Multiple `Directory.Packages.props` are defined
- The root level has the lowest version of the defined packages in the repo
- The sub `Directory.Packages.props` imports the root and defines a higher version `Update` on a transitive dependency of another package
- A project under the sub-`Directory.Packages.props` has a `PackageReference` on direct dependency which falls through to the root `Directory.Packages.props`
- The version of the transitive dependency is now pinned to the updated version
- A project under the root `Directory.Packages.props` has a `ProjectReference` on the other project

The other branches in this repo show how any small variation of this either results in `NU1109` (caught at restore-time), or a passing build - but not `MSB3277`.

Helper script to run a build on every branch for comparison:

```pwsh
.\RunMSBuildAll.ps1
```
