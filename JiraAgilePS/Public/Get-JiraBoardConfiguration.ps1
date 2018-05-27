function Get-JiraBoardConfiguration {
    [CmdletBinding()]
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [PSObject]
        $Board,

        [Int]
        $PageSize = 50,

        [PSCredential]
        $Credential
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $resourceURi = "{0}/configuration"
    }

    process {
        foreach ($_board in $Board) {
            if ($_board -is [Int]) {
                $_board = Get-JiraBoard $_board
            }
            $parameter = @{
                URI          = $resourceURi -f $_board.self
                Method       = "GET"
                Credential   = $Credential
                GetParameter = @{
                    maxResults = $PageSize
                }
            }
            Invoke-JiraMethod @parameter
        }
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}
