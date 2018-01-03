import React from "react"
import PropTypes from "prop-types"

class BoxedList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isVisible: false };
    this.toggleVisible = this.toggleVisible.bind(this);
  }

  toggleVisible () {
    var iV = ! this.state.isVisible;
    this.setState( {isVisible: iV } );
  }

  render () {
    var toggleLink = "";
    if( this.props.links.length ) {
      toggleLink = (
        <a className="quiet blue-highlight" href="#" onClick={this.toggleVisible}>
          &nbsp;{ this.state.isVisible ? "-" : "+" }&nbsp;
        </a>
      );
    }
    return (
      <span>
        <span style={{float: 'left'}} >{ toggleLink }</span>
        <div className="fixed-table">
          <div style={ this.state.isVisible ? {display: 'none'} : null }>
            <span className="bordered-grid footnote">{this.props.countHeader}</span>
          </div>
          <div style={ this.state.isVisible ? null : {display: 'none'} }>
            <ul className="bordered-grid loose-grid">
              { this.props.links.map((link, mIdx) => (
                <li key={link.name}>
                  <a className="quiet" title={link.name} {...link.opts} href={link.url}>{link.name}</a>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </span>
    );
  }
}

BoxedList.propTypes = {
  countHeader: PropTypes.string,
  links: PropTypes.array
};
export default BoxedList;
