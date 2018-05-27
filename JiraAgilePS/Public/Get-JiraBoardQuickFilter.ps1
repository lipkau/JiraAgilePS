function Get-JiraBoardQuickFilter {
    [CmdletBinding( DefaultParameterSetName = '_All' )]
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [PSObject]
        $Board,

        [Parameter( ValueFromPipelineByPropertyName, ParameterSetName = '_Search' )]
        [Int]
        $QuickFilter,

        [Int]
        $PageSize = 50,

        [PSCredential]
        $Credential
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $server = Get-JiraConfigServer -ErrorAction Stop

        $resourceURi = "{0}/quickfilter{1}"
    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            '_All' {
                foreach ($_board in $Board) {
                    if ($_board -is [Int]) {
                        $_board = Get-JiraBoard $_board
                    }
                    $parameter = @{
                        URI          = $resourceURi -f $_board.self, ""
                        Method       = "GET"
                        Credential   = $Credential
                        Paging = $true
                        GetParameter = @{
                            maxResults = $PageSize
                        }
                    }
                    Invoke-JiraMethod @parameter
                }
            }
            '_Search' {
                foreach ($_board in $Board) {
                    Write-Verbose "[$($MyInvocation.MyCommand.Name)] Processing [$_board]"
                    Write-Debug "[$($MyInvocation.MyCommand.Name)] Processing `$_board [$_board]"

                    foreach ($_quickFilter in $QuickFilter) {
                        $parameter = @{
                            URI          = $resourceURi -f $_board.self, $_quickFilter
                            Method       = "GET"
                            Credential   = $Credential
                            GetParameter = @{
                                maxResults = $PageSize
                            }
                        }
                        Invoke-JiraMethod @parameter
                    }
                }
            }
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
