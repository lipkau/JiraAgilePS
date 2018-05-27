function Get-JiraBoard {
    [CmdletBinding( DefaultParameterSetName = '_All' )]
    param(
        [Parameter( Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = '_Search' )]
        [Alias("Id")]
        [Int[]]
        $Board,

        [Int]
        $PageSize = 50,

        [PSCredential]
        $Credential
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $server = Get-JiraConfigServer -ErrorAction Stop

        $resourceURi = "$server/rest/agile/1.0/board{0}"
    }

    process {
        switch ($PSCmdlet.ParameterSetName) {
            '_All' {
                $parameter = @{
                    URI          = $resourceURi -f ""
                    Method       = "GET"
                    Credential   = $Credential
                    Paging       = $true
                    GetParameter = @{
                        maxResults = $PageSize
                    }
                    # Verbose    = $Verbose
                    # Debug = $Debug
                }
                Invoke-JiraMethod @parameter
            }
            '_Search' {
                foreach ($_board in $Board) {
                    Write-Verbose "[$($MyInvocation.MyCommand.Name)] Processing [$_board]"
                    Write-Debug "[$($MyInvocation.MyCommand.Name)] Processing `$_board [$_board]"

                    $parameter = @{
                        URI        = $resourceURi -f "/$($_board)"
                        Method     = "GET"
                        Credential = $Credential
                    }
                    Invoke-JiraMethod @parameter
                }
            }
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
